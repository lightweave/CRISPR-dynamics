% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Si Fraction of class Fi that stays unchanged
function S=Stay1(p,N)
 S=zeros(1,N);
    for i=1:N
        S(i)=(1-p);%+p*(q(i)*(h*Pmu(nu,0)+(1-h)*g*Pmu(mnu,0))+s*(1-q(i))*Pmu(ku,0)); 
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%