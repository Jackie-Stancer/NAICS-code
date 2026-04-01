clear;clc;

warning off;
caseFileName = '';
P = imread(caseFileName);

[pathstr,name,suffix]=fileparts(caseFileName);

% %Locate the airport
[x,y,w,h,img_size] = get_location(P,name);
Ar = img_size(1,1);
Ac = img_size(1,2);
% % mask_airport = cat(3, R2_mask,G2_mask,B2_mask);
mask_airport = P;
mask_airport(y:y+h,x:x+w,:) = 0;
a = x+w;
b = y+h;

[P_com] = Function_inpainting(mask_airport, x, a, y, b);

imwrite(P_com,'091_P_com.png');
[P_airport]=imcrop(P,[x y w h]);
R1=P_airport(:,:,1);G1=P_airport(:,:,2);B1=P_airport(:,:,3);
% imwrite(P_airport,'rainforest4.png');
tic
R2 = encrypt_function(R1);
G2 = encrypt_function(G1);
B2 = encrypt_function(B1);
encrypt_t = toc;
disp(['encrypt_time: ',int2str(encrypt_t*100000),'ms']);

EE = cat(3,R2,G2,B2);
% imwrite(uint8(EE),'010_com.png');

save test1 R2 G2 B2 P_com


%Embed the airport image to entire areas on YCrBr level
tic
[C_p] = embed2(R2, G2, B2, P_com);
embed_t = toc;
disp(['embed_time: ',int2str(embed_t*100000),'ms']);

save loc x y w h 

imwrite(C_p, '091_en.png');