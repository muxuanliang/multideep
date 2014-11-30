function IDX=ID(h,U)
[q1,q2]=size(U);
[k1,k2]=size(h);
IDX=zeros(k2,1);
for i=1:k2
    for j=1:q2
        if (h(:,i)==U(:,j))
        IDX(i)=j;
        end
    end
end