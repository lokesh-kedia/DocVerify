function main(filename)%%to clear
%clear; close all; clc
%load datas to perticular values
%images = loadMNISTImages('train-images.idx3-ubyte');
load("X.mat");
%labels = loadMNISTLabels('train-labels.idx1-ubyte');
load("y.mat");
%load('data1a.mat');
%a=cast(a,"double");
%X=a;
%load('data1y.mat');
%y=y;

%displayData(X(1:10,:));
fprintf('\nTesting lrCostFunction() with regularization');

theta_t = [-2; -1; 1; 2];
X_t = [ones(5,1) reshape(1:15,5,3)/10];
y_t = ([1;0;1;0;1] >= 0.5);
lambda_t = 3;
[J grad] = lrcostfunction(theta_t, X_t, y_t, lambda_t);

fprintf('\nCost: %f\n', J);
fprintf('Expected cost: 2.534819\n');
fprintf('Gradients:\n');
fprintf(' %f \n', grad);
fprintf('Expected gradients:\n');
fprintf(' 0.146561\n -0.548558\n 0.724722\n 1.398003\n');




m=size(X,1);
n=size(X,2);
num_labels=10;
lambda=0.1;
theta=zeros(n+1,1);
[all_theta]=onevsall(X,y,num_labels,lambda);
pred=predictOneVsAll(all_theta,X);
fprintf('\nTraining Set Accuracy: %f\n',mean(double(pred==y))*100);









%accuray=[9;6;3;10;2;1;5;4;10;8;5;8];
%tc= loadMNISTImages('t10k-images.idx3-ubyte');
%tc=tc';
tc=ocr(filename);
tc=imageTo20x20Gray_1(tc);

%load('tc.mat');
fprintf('\nAadhar Number ');
pred=mod(predictOneVsAll(all_theta,tc),10);
prediction=pred'
%fprintf('\nTraining Set Accuracy: %f\n',mean(double(pred==accuray))*100);
m=12;
rp = randperm(m);

for i = 1:m
    % Display 
    %fprintf('\nDisplaying Example Image\n');
    %displayData(tc(rp(i), :));

    pred = predictOneVsAll(all_theta,tc(rp(i),:));
   % fprintf('\nNeural Network Prediction: %d (digit %d)\n', pred, mod(pred, 10));
    
    % Pause with quit option
  % s = input('Paused - press enter to continue, q to exit:','s');
  %  if s == 'q'
   %   break
   % end
end
end