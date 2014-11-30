function X=bat(data,nbat)
[a1,a2]=size(data);
X=zeros(a1,nbat);
IDX=randi(a2,nbat,1);
for i=1:nbat
X(:,i)=data(:,IDX(i));
end