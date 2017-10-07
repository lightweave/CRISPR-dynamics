% Delta(i,j)
function D=DeLij(Nu,N,L)
format long
D=zeros(N,N);
    for i=1:N
        for j=1:i
            D(i,j)=Nu(i)*L(i,j); 
        end
    end   
end
