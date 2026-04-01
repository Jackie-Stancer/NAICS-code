function [B]=DCML(k1,k2,k3,k4,k5,k6,Ar,Ac,p,q)
kp=p*q+(Ar*Ac)/8;
alpha=6;
  mu=mod(100*(k3+k4)/3,4);
  e=mod(100*(k5+k6)/3,1);

 lattice=8;
 Key(1) = mod(e+k1,1);
 Key(2) = mod(e+Key(1),1);
 Key(3) = mod(e+Key(2),1);
 Key(4) = mod(e+Key(3),1);
 Key(5) = mod(e+Key(4),1);
 Key(6) = mod(e+Key(5),1);
 Key(7) = mod(e+Key(6),1);
 Key(8) = mod(e+Key(7),1); 
    
 x(1:lattice)=Key(1:8);
  
  i=0;
  flag=1;
  for n=1:kp
      for m=1:lattice
            j=mod((m+p*m),lattice);
            k=mod(q*m+(p*q+1)*m,lattice);
          if j==0;
              j=lattice;
          end
          if k==0;
              k=lattice;
          end
          

   y(m)=(1-e)*(mod(alpha*(1-3*alpha*sin(pi*x(m)))^2,1)) +((e/2)*((mod(alpha*(1-3*alpha*sin(pi*x(j)))^2,1))   + (mod(alpha*(1-3*alpha*sin(pi*x(k)))^2,1))   )); 
          e=mod(mu*(1-3*mu*sin(pi*e))^2,1);
          if flag==1
              if n>200
                  i=i+1;
                  Ks(i)=y(m);
                  if i>2
                      flag=0;
                  end
              end
          end
      end
      x(:)=y(:);
      B(1:8,n)=y(1:8);
  end

end