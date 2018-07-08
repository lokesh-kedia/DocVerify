function [all_theta]=onevsall(X,y,num_labels,lambda)
  m=size(X,1);
  n=size(X,2);
  all_theta=zeros(num_labels,n+1);
  X=[ones(m,1) X];
  theta=zeros(n+1,1);
 initial_theta = zeros(n + 1, 1);
options=optimset('GradObj','on','MaxIter',50);
for i=1:num_labels
	
	all_theta(i,:)=fmincg(@(t)(lrcostfunction(t,X,(y==i),lambda)),initial_theta,options);

end;

endfunction
