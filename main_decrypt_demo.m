clear;clc;
C = imread('001_en.png');
load loc

[R2, G2, B2] = embed2_extract(C, w+1, h+1);

R = encrypt_function_de(R2);
G = encrypt_function_de(G2);
B = encrypt_function_de(B2);

airport = cat(3, R, G, B);
C(y:y+h,x:x+w,:) = airport;

imwrite(C, '001_de.png');





