function [W,a,b,hs,h,d,d1] = rbm(data1,nh,nCD,nstep,nbat,maxepoch,lamda1,lamda2)
%RBM is the training function for gaussian visible layer and binary hidden
%layer rbm
%each column represents data of single person
[k1,k2]=size(data1);
Win=0*randn(nh,k1);
W=Win;
ain=zeros(k1,1);
a=ain;
bin=zeros(nh,1);
b=bin;
d=zeros(maxepoch,1);
d1=zeros(maxepoch,1);
d1(1)=norm(W);
for i=1:maxepoch
[W1,a,b]=TDBN1(data1,nh,W,a,b,nCD,nstep,nbat,lamda1,lamda2);
d(i)=norm(W1-W);
d1(i)=norm(W1);
W=W1;
end
h=1./(1+exp(-W*data1-repmat(b,1,k2)));
hs=(h>rand(size(h)));
end

