% y = a x^b
function [a, b] = my_powerLawFit(y, x)

logx=log(x);
logy=log(y);
p=polyfit(logx,logy,1);
b=p(1);
loga=p(2);
a=exp(loga);

end 
