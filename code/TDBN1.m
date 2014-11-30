function [W,a,b]=TDBN1(data,nh,Win,ain,bin,nCD,step,nbat,lamda1,lamda2)

%%%%%%%%% Gaussian-binary RBM updates program %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Data Represented by Column %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[a1,a2]=size(data);
data=bat(data,nbat);
W=zeros(nh,a1);
a=zeros(a1,1);
b=zeros(nh,1);

%%%%%%%%% START POSITIVE PHASE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hp=1./(1+exp(-Win*data-repmat(bin,1,nbat)));
hs=(hp>rand(size(hp)));
W=W+hp*data';
a=a+sum(data,2);
b=b+sum(hp,2);
hpp=hp;

%%%%%%%%% END OF POSITIVE PHASE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% START NEGATIVE PHASE  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:nCD
    vs=Win'*hpp+repmat(ain,1,nbat);
    hpp=1./(1+exp(-Win*vs-repmat(bin,1,nbat)));
end

%%%%%%%%% END OF NEGATIVE PHASE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% UPDATE WEIGHTS AND BIASES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

W=W-hpp*vs';
a=a-sum(vs,2);
b=b-sum(hpp,2);
%W=((1-2*step*lamda2).*Win+step/nbat*W)./(1+2*step*lamda1./abs(Win));
W=((1-2*step*lamda2).*Win+step/nbat*W);
a=ain+step/nbat*a;
b=bin+step/nbat*b;
%%%%%%%%%%%%%%%% END OF UPDATES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

