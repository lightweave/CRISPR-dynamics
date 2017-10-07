%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ballance Death and Cloning
function a=Alpha(p,s,h,g,nu,ku,mnu,N,q,Nu,Fo,Fh)

Death=zeros(1,N);
for i=1:N    
    Death(i)=p*(q(i)*(h*exp(-nu*(N-i))+(1-h)*g*exp(-mnu*(N-i))+(1-h)*(1-g))+(1-q(i))*(s*exp(-ku*(N-i))+(1-s)));
end
    
Ds=sum(Death.*Fo');
Rs=sum(Nu.*Fh');
a=Ds/Rs;
    
end
