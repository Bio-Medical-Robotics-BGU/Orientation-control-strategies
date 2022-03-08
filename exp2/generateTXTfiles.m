function [] = generateTXTfiles(Kgroup1,Kgroup2,Kgroup3)

%% TEXT FILES FOR R SPHERICAL ANOVA
%---------------- within groups comparison ---------------- 
% trial 121 - first exposure
writematrix(squeeze(Kgroup1(121,:,:))','trial121G1.txt','Delimiter','space')
CC = confidenceCone(squeeze(Kgroup1(121,:,:))',0.95);
writematrix(squeeze(Kgroup2(121,:,:))','trial121G2.txt','Delimiter','space')
CC = confidenceCone(squeeze(Kgroup2(121,:,:))',0.95);
writematrix(squeeze(Kgroup3(121,:,:))','trial121G3.txt','Delimiter','space')
CC = confidenceCone(squeeze(Kgroup3(121,:,:))',0.95);
% trial 300 - partial adaptation only
writematrix(squeeze(Kgroup1(300,:,:))','trial300G1.txt','Delimiter','space')
CC = confidenceCone(squeeze(Kgroup1(300,:,:))',0.95);
writematrix(squeeze(Kgroup2(300,:,:))','trial300G2.txt','Delimiter','space')
CC = confidenceCone(squeeze(Kgroup2(300,:,:))',0.95);
writematrix(squeeze(Kgroup3(300,:,:))','trial300G3.txt','Delimiter','space')
CC = confidenceCone(squeeze(Kgroup3(300,:,:))',0.95);
% trial 121 and 300 - adaptation
writematrix([squeeze(Kgroup1(121,:,:))';squeeze(Kgroup1(300,:,:))'],'trial121_300G1.txt','Delimiter','space')
writematrix([squeeze(Kgroup2(121,:,:))';squeeze(Kgroup2(300,:,:))'],'trial121_300G2.txt','Delimiter','space')
writematrix([squeeze(Kgroup3(121,:,:))';squeeze(Kgroup3(300,:,:))'],'trial121_300G3.txt','Delimiter','space')
% trial 301 - aftereffect
writematrix(squeeze(Kgroup1(301,:,:))','trial301G1.txt','Delimiter','space')
writematrix(squeeze(Kgroup2(301,:,:))','trial301G2.txt','Delimiter','space')
writematrix(squeeze(Kgroup3(301,:,:))','trial301G3.txt','Delimiter','space')
% trial 360 - washout
writematrix(squeeze(Kgroup1(360,:,:))','trial360G1.txt','Delimiter','space')
writematrix(squeeze(Kgroup2(360,:,:))','trial360G2.txt','Delimiter','space')
writematrix(squeeze(Kgroup3(360,:,:))','trial360G3.txt','Delimiter','space')
% trial 301 and 360 - washout
writematrix([squeeze(Kgroup1(301,:,:))';squeeze(Kgroup1(360,:,:))'],'trial301_360G1.txt','Delimiter','space')
writematrix([squeeze(Kgroup2(301,:,:))';squeeze(Kgroup2(360,:,:))'],'trial301_360G2.txt','Delimiter','space')
writematrix([squeeze(Kgroup3(301,:,:))';squeeze(Kgroup3(360,:,:))'],'trial301_360G3.txt','Delimiter','space')
% trial 301 and 300 (rotated) - partial transfer of learning
quat = rotm2quat(rotx(-90)); quati = quatinv(quat);
quatrep = repmat(quat,10,1); quatirep = repmat(quati,10,1);
quatG1 = quatmultiply(quatmultiply(quatrep,[zeros(10,1),squeeze(Kgroup1(300,:,:))']),quatirep);
writematrix([squeeze(Kgroup1(301,:,:))';quatG1(:,2:4)],'trial301_300r90G1.txt','Delimiter','space')
% trial 60 and 121
writematrix([squeeze(Kgroup1(60,:,:))';squeeze(Kgroup1(121,:,:))'],'trial60_121G1.txt','Delimiter','space')
writematrix([squeeze(Kgroup2(60,:,:))';squeeze(Kgroup2(121,:,:))'],'trial60_121G2.txt','Delimiter','space')
writematrix([squeeze(Kgroup3(60,:,:))';squeeze(Kgroup3(121,:,:))'],'trial60_121G3.txt','Delimiter','space')
% trial 60 and 300
quat = rotm2quat(rotx(-60)); quati = quatinv(quat);
quatrep = repmat(quat,10,1); quatirep = repmat(quati,10,1);
quatG1 = quatmultiply(quatmultiply(quatrep,[zeros(10,1),squeeze(Kgroup1(60,:,:))']),quatirep);
quatG2 = quatmultiply(quatmultiply(quatrep,[zeros(10,1),squeeze(Kgroup2(60,:,:))']),quatirep);
quatG3 = quatmultiply(quatmultiply(quatrep,[zeros(10,1),squeeze(Kgroup3(60,:,:))']),quatirep);
writematrix([quatG1(:,2:4);squeeze(Kgroup1(300,:,:))'],'trial60_300G1.txt','Delimiter','space')
writematrix([quatG2(:,2:4);squeeze(Kgroup2(300,:,:))'],'trial60_300G2.txt','Delimiter','space')
writematrix([quatG3(:,2:4);squeeze(Kgroup3(300,:,:))'],'trial60_300G3.txt','Delimiter','space')
% trial 120 and 301
writematrix([squeeze(Kgroup1(120,:,:))';squeeze(Kgroup1(301,:,:))'],'trial120_301G1.txt','Delimiter','space')
writematrix([squeeze(Kgroup2(120,:,:))';squeeze(Kgroup2(301,:,:))'],'trial120_301G2.txt','Delimiter','space')
writematrix([squeeze(Kgroup3(120,:,:))';squeeze(Kgroup3(301,:,:))'],'trial120_301G3.txt','Delimiter','space')
% trial 120 and 360
writematrix([squeeze(Kgroup1(120,:,:))';squeeze(Kgroup1(360,:,:))'],'trial120_360G1.txt','Delimiter','space')
writematrix([squeeze(Kgroup2(120,:,:))';squeeze(Kgroup2(360,:,:))'],'trial120_360G2.txt','Delimiter','space')
writematrix([squeeze(Kgroup3(120,:,:))';squeeze(Kgroup3(360,:,:))'],'trial120_360G3.txt','Delimiter','space')
%---------------- between groups comparison ----------------
% trial 60 - BL1
quat = rotm2quat(rotx(-90)); quati = quatinv(quat);
quatrep = repmat(quat,10,1); quatirep = repmat(quati,10,1);
quatG1 = quatmultiply(quatmultiply(quatrep,[zeros(10,1),squeeze(Kgroup1(60,:,:))']),quatirep);
writematrix([quatG1(:,2:4);squeeze(Kgroup2(60,:,:))';squeeze(Kgroup3(60,:,:))'],'trial60G123.txt','Delimiter','space')
% trial 120 - BL2
quat = rotm2quat(rotx(-90)); quati = quatinv(quat);
quatrep = repmat(quat,10,1); quatirep = repmat(quati,10,1);
quatG3 = quatmultiply(quatmultiply(quatrep,[zeros(10,1),squeeze(Kgroup3(120,:,:))']),quatirep);
writematrix([squeeze(Kgroup1(120,:,:))';squeeze(Kgroup2(120,:,:))';quatG3(:,2:4)],'trial120G123.txt','Delimiter','space')
% trial 121 - first exposure
quat = rotm2quat(rotx(-90)); quati = quatinv(quat);
quatrep = repmat(quat,10,1); quatirep = repmat(quati,10,1);
quatG1 = quatmultiply(quatmultiply(quatrep,[zeros(10,1),squeeze(Kgroup1(121,:,:))']),quatirep);
writematrix([quatG1(:,2:4);squeeze(Kgroup2(121,:,:))';squeeze(Kgroup3(121,:,:))'],'trial121G123.txt','Delimiter','space')
% trial 300 - last exposure
quat = rotm2quat(rotx(-90)); quati = quatinv(quat);
quatrep = repmat(quat,10,1); quatirep = repmat(quati,10,1);
quatG1 = quatmultiply(quatmultiply(quatrep,[zeros(10,1),squeeze(Kgroup1(300,:,:))']),quatirep);
writematrix([quatG1(:,2:4);squeeze(Kgroup2(300,:,:))';squeeze(Kgroup3(300,:,:))'],'trial300G123.txt','Delimiter','space')
% trial 301 - aftereffect
quat = rotm2quat(rotx(-90)); quati = quatinv(quat);
quatrep = repmat(quat,10,1); quatirep = repmat(quati,10,1);
quatG3 = quatmultiply(quatmultiply(quatrep,[zeros(10,1),squeeze(Kgroup3(301,:,:))']),quatirep);
writematrix([squeeze(Kgroup1(301,:,:))';squeeze(Kgroup2(301,:,:))';quatG3(:,2:4)],'trial301G123.txt','Delimiter','space')
% trial mean(301-303) - aftereffect - averaging the first 3 trials of TFR
for i=1:10
    KG1(i,:) = meanDirection3D(Kgroup1(301:303,:,i))';
    KG2(i,:) = meanDirection3D(Kgroup2(301:303,:,i))';
    KG3(i,:) = meanDirection3D(Kgroup3(301:303,:,i))';
end
quat = rotm2quat(rotx(-90)); quati = quatinv(quat);
quatrep = repmat(quat,10,1); quatirep = repmat(quati,10,1);
quatG3 = quatmultiply(quatmultiply(quatrep,[zeros(10,1),KG3]),quatirep);
writematrix([KG1;KG2;quatG3(:,2:4)],'meantrial301_302_303G123.txt','Delimiter','space')
quat = rotm2quat(rotx(-90)); quati = quatinv(quat);
quatrep = repmat(quat,10,1); quatirep = repmat(quati,10,1);
quatG3 = quatmultiply(quatmultiply(quatrep,[zeros(10,1),squeeze(Kgroup3(360,:,:))']),quatirep);
writematrix([squeeze(Kgroup1(360,:,:))';squeeze(Kgroup2(360,:,:))';quatG3(:,2:4)],'trial360G123.txt','Delimiter','space')