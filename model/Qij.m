%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q(i,j)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Q=Qij(q,p,s,h,g,N,nu,ku,mnu)
format long
Q=zeros(N,N);
    for i=1:N
        for j=i:N
            Q(i,j)=p*(q(i)*(h*Pmu(nu,j-i)+(1-h)*g*Pmu(mnu,j-i))+(1-q(i))*s*Pmu(ku,j-i));
        end
        %Q(i,N)=p*(q(i)*exp(-nu*(N-i))+(1-q(i))*s*exp(-ku*(N-i))); % get the whole distribution tail     
    end
end