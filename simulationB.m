% BOFMM using MATLAB

clc;
clear all;
close all;

load('CL2.mat');
CL = costMatrix;
load('CU2.mat');
CU = costMatrix;


C1 = CL;
C2 = CU;

% C1 = CU;
% C2 = CL;

lim1 = 100000;
lim2 = 100000;
t1=clock;

   
t3=clock; 
plan1 = FMM(C1); 
t4=clock; 
[C,maxi] = Huang(C1,plan1,C2);
t5=clock; 
plan2 = FMM(C); 
t6=clock; 



if maxi~=length(plan1) 
    plan = [plan2(1:maxi) plan1(maxi) plan2(maxi+1:end)];
else
    plan = [plan2(1:maxi) plan1(maxi)]; 
end


lim1 = C1(maxi,plan1(maxi));


n = length(plan);
for k =1:n
    if k ==1
       lim2= C2(k,plan(k));
    else
        if lim2< C2(k,plan(k))
            lim2= C2(k,plan(k));
        end
    end
end 

t7=clock;
t2=clock;
             
fprintf('max cost1:%g£¬max cost 2:%g\n',lim1,lim2);
fprintf('calculation time total:%g\n\n',etime(t2,t1));    
fprintf('calculation time1:%g\n',etime(t4,t3));
fprintf('calculation time2:%g\n',etime(t5,t4));
fprintf('calculation time3:%g\n',etime(t6,t5));
fprintf('calculation time4:%g\n',etime(t7,t6));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [C,maxi] = Huang(C1,plan,C2)

    a = length(C1);
    planmax = 0;
    
    
    for i = 1:a
        b = C1(i,plan(i));
        if planmax < b
            planmax = b;
            maxi = i;
        end
    end
    
   
    C1(C1>=planmax)=10000;
    C1(C1<=planmax)=0;
    C = C1+C2;
    
    
    C(maxi,:) = []; 
    C(:,plan(maxi)) = []; 
end



