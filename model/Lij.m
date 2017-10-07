%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Spacer Loss 
function l=Lij(MuDel,N)
    l=zeros(N,N);
    l(1,1)=1; %clones from first class stay in first class
    l(2,1)=exp(-MuDel(2));
    l(2,2)=1-exp(-MuDel(2));
    for i=3:N        
        l(i,1)=exp(-MuDel(i)*(i-1));    
        for j=2:i-1
            l(i,j)=exp(-MuDel(i)*(i-j))-exp(-MuDel(i)*(i-j+1));
        end
        l(i,i)=1-exp(-MuDel(i)); % no spacer loss  
    end
end
