%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transition matrix 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A=matrixA1(N,Si1,Q)

 A=zeros(N,N);
% Matrix A1 bacteria-virus interaction. 
%-------- Lower Triangular Region------------------------------------------    
    for i=2:N
        for j=1:(i-1)
            A(i,j)=Q(j,i);
        end
    end
        
 %------A(i,i)-------------------------------------------------------------
    for i=1:N
        A(i,i)=Si1(i); 
    end
   
end