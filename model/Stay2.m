% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Si Fraction of class Fi that stays unchanged
function S=Stay2(Nu_i,MuD,N)
 S=zeros(1,N);
    S(1)=1+Nu_i(1);
    for i=2:N
        S(i)=1+Nu_i(i)*(1-exp(-MuD(i))); 
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%