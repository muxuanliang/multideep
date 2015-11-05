%%%%%%%%%%%%%%%%%%%%%%%%% Standarlize Data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
datarna=importdata('3.miRNA_0.5.out');
datage=importdata('3.GE1_0.5.out');
datame=importdata('3.Methylation_0.5.out');
datarna.data=datarna.data';
datage.data=datage.data';
datame.data=datame.data';
datarna.data=zscore(datarna.data);
datage.data=zscore(datage.data);
datame.data=zscore(datame.data);
datarna.data=datarna.data';
datage.data=datage.data';
datame.data=datame.data';

%%%%%%%%%%%%%%%%%%%%%%%%%% Modality for RNA Data %%%%%%%%%%%%%%%%%%%%%%%%%%
[W1,a1,b1,hs1,h1,d1,dd1]=rbm(datarna.data,40,10,0.0005,1,80000,0.1,0.1);

%%%%%%%%%%%%%%%%%%%%%%%%%% Modelity for GE Data %%%%%%%%%%%%%%%%%%%%%%%%%%%
[W2,a2,b2,hs2,h2,d2,dd2]=rbm(datage.data,400,1,0.0005,1,8000,1,1);
[err21,h21,WW1]=rbmtop(h2',40,800,1);

%%%%%%%%%%%%%%%%%%%%%%%%%% Modelity for ME Data %%%%%%%%%%%%%%%%%%%%%%%%%%%
[W3,a3,b3,hs3,h3,d3,dd3]=rbm(datame.data,400,1,0.0005,1,8000,1,1);
[err31,h31,WW2]=rbmtop(h3',40,800,1);



%%%%%%%%%%%%%%%%%%%%%%%%%% Modality for Joint Data (RNA, GE,ME Data) %%%%%%
H1=[h1',h21,h31];
[err,H2,WW3]=rbmtop(H1,24,800,1);
[err0,H3,WW4]=rbmtop(H2,8,800,1);

%%%%%%%%%%%%%%%%%%%%%%%%%% Use H3 for Further Clustering %%%%%%%%%%%%%%%%%%
H3s=(H3>0.8)-(H3<0.2);
U=unique(H3s,'rows');
U=U';
IDX=ID(H3s',U);

