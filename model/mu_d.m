%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Average spacer loss depends on the length of the clone
function m=mu_d(N,fu,SL)
m=zeros(1,N);
m(1)=0;
    for i=2:N
        m(i)=fu/(SL*i); %on average 1/2 spacers *fu should be lost
    end
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
