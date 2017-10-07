%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Transition matrix A2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function A=matrixA2(N,Si,Del)
A=zeros(N,N);    
% Matrix for Cloning    
%------ Upper Triangular Region-------------------------------------------    
for i=1:(N-1)
   for j=(i+1):N
      A(i,j)=Del(j,i);
   end
end     
 %------A(i,i)-------------------------------------------------------------
for i=1:N
      A(i,i)=Si(i);
end

end