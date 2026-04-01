function [P_pur] = purmulate(Ar,Ac,P,BN,a,b)
P = double(P);
s = Ar*Ac;
P_pur = zeros(1,s);
S1 = zeros(2,s);
c=10; 

A1=[2 1;4 3]; 
A2=[4 1;3 2]; 
E=A1;

Max_A2 = max(A2(:));
B = zeros(2, 2);

for k=2:c 
    [N, w] =size(E); 

    A1 = E;

    for i = 1:N
        for j = 1:N
            B = Max_A2 * (A1(i,j)-1)+A2;
            C(2*(i-1)+1:2*(i-1)+2,2*(j-1)+1:2*(j-1)+2) = B;
        end
    end
    
    N = size(C);
    N= N(1,1);
    M = C;

    for n =1:50
    for y = 1:N
        for x=1:N           
            xx=mod((x-1)+b*(y-1),N)+1;   
            yy=mod(a*(x-1)+(a*b+1)*(y-1),N)+1;        
            C(yy,xx)=M(y,x);                
        end
    end
        M = C;
    end


    E=C;
end
%ห๗าýสýื้
k=1;
for i = 1:Ar
    for j = 1:Ac
        S1(1,k) = k;
        S1(2,k) = E(i,j);
        k=k+1;
    end
end
S1_index=sortrows(S1',2)';
Sor = S1_index(1,:);
P_arr = reshape(P,[1,Ar*Ac]);
tic;
P_pur(1) = mod(P_arr(Sor(1)) +floor(BN(1))+ floor((13.66*(1-3*13.66*sin(pi*20/256))^2)*10^10),256);

for i =2:s
P_pur(i) = mod(P_arr(Sor(i)) +floor(BN(i))+ floor((13.66*(1-3*13.66*sin(pi*P_pur(i-1)/256))^2)*10^10),256);
end
toc;

P_pur = reshape(P_pur,[Ar,Ac]);
