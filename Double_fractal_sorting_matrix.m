clear all;
close all;
c=9; 
E=cell(1,c);  
F=cell(1,c);
A1=[2 1;4 3]; 
A2=[4 1;3 2]; 
a = 18;
b = 26;
E{1}=A1;

Max_A2 = max(A2(:));
B = zeros(2, 2);
tic
for k=2:c 
    q=k-1; 
    [N, w] =size(E{q}); 

    A1 = E{q};

    for i = 1:N
        for j = 1:N
            B = Max_A2 * (A1(i,j)-1)+A2;
            C(2*(i-1)+1:2*(i-1)+2,2*(j-1)+1:2*(j-1)+2) = B;
        end
    end

    N = size(C);
    N= N(1,1);
    M = C;

    for n =1:20
    for y = 1:N
        for x=1:N           
            xx=mod((x-1)+b*(y-1),N)+1;  
            yy=mod(a*(x-1)+(a*b+1)*(y-1),N)+1;        
            C(yy,xx)=M(y,x);                
        end
    end
        M = C;
    end

    E{k}=C;

end
toc
