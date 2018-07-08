function [J grad]=lrcostfunction(theta,X,y,lambda)
  m=size(X,1);
  J=0;
  grad=zeros(size(theta));
  z=X*theta;
  g=sigmoid(z);
  J=-(1/m)*sum((y.*log(g))+((1-y).*log(1-g)));
  theta(1)=0;
  J=J+(lambda/(2*m))*(theta'*theta);
  grad=(1/m)*(X'*(g-y))+(lambda/m)*theta;
  grad=grad(:);
endfunction
