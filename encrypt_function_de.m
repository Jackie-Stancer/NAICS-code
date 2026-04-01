function [C] = encrypt_function_de(P)

P = double(P);

[m,n] = size(P);

avg = 122;
k1 = 61.147+avg;
k2 = 53.1789+avg;
k3 = 66.748+avg;
k4 = 542.473+avg;
k5 = 21.475+avg;
k6 = 47.45664+avg;
p=10+floor(avg/4);
q=10+floor(avg/6);
% save key k1 k2 k3 k4 k5 k6
tic
[B] = DCML(k1,k2,k3,k4,k5,k6,m,n,p,q);
toc
sB = size(B);
a = sB(1,2);
B5 = reshape(B,1,8*a);
B5 = B5(100:100+m*n-1);
BN = B5*10^9;
C = purmulate_de(m,n,P,BN,p,q);
C = uint8(C);


