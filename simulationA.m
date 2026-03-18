% FMM using MATLAB

clc;
clear all;
close all;

NUM=100; % USV number

% [D,Max] = init(i);
% load('CL1.mat');       
load('CU1.mat');
D =costMatrix;

t1=clock; 
plan = FMM(D); 
t2=clock; 

n = size(D,1);
sum=0;
for k =1:n
    sum=sum+D(k,plan(k)); 
    if k ==1
       lim= D(k,plan(k));
    else if lim< D(k,plan(k))
            lim= D(k,plan(k));
        end
    end
end 

fprintf('max cost：%g，total cost：%g\n',lim,sum);
fprintf('calculation time：%g\n\n',etime(t2,t1));

T=etime(t2,t1); 
TC=sum; 
MC=lim;    





