function [assignment] = FMM(costMat)

A = costMat;
A_length=length(A);
B=zeros(A_length); 

[sA,index] = sort(reshape(A',1,[]));
a = 0;
n = 0;

for i=1:A_length * A_length

    index_column = mod(index(i),A_length);
    index_row = (index(i)-index_column)/A_length;
    
    if index_column == 0
        index_column = A_length;
        index_row = index_row - 1;
    end

    B(index_row + 1,index_column) = A(index_row + 1,index_column);

    if sum(all(B==0,2))==0 && sum(all(B==0,1))==0
        
        t1=clock;
        C= B;
        C=C .*rand(A_length,A_length);
        if rank(C) == A_length 
            B(B==0) = NaN;
            assignment = KM(B);
            return;        
        else
            t2=clock;
            n = n+1;
            a = a + etime(t2,t1);
        end
        
    end
end
