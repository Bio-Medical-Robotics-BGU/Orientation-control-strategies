function ranovatbl = exp1_statistics()
%% Statistics - experiment 1

load('exp1_QGS.mat')
Np = size(QGS,1);
Ntr = size(QGS,2);

group = categorical([2*ones(7,1);ones(7,1)]);
alignment_cat = categorical(repmat([ones(6,1);2*ones(6,1)],4,1));
frame_cat = categorical(repmat([ones(3,1);2*ones(3,1)],8,1));
initial_orientation_cat = categorical([ones(12,1);2*ones(12,1);0*ones(12,1);0*ones(12,1)]);
target_orientation_cat = categorical([0*ones(12,1);0*ones(12,1);1*ones(12,1);2*ones(12,1)]);
rotation_axis_cat = categorical(repmat([1 2 3 1 2 3 4 5 6 4 5 6]',4,1));
within = table(initial_orientation_cat,target_orientation_cat,alignment_cat,frame_cat,rotation_axis_cat,'VariableNames',{'initial_orientation','target_orientation','alignment','frame','rotation_axis'});

intrinsic_axis_G1 = textread('kaG1.txt'); intrinsic_axis_G1(1:24) = []; intrinsic_axis_G2 = textread('kaG2.txt'); intrinsic_axis_G2(1:24) = [];
extrinsic_axis_G1 = textread('kbG1.txt'); extrinsic_axis_G1(1:24) = []; extrinsic_axis_G2 = textread('kbG2.txt'); extrinsic_axis_G2(1:24) = [];
initial_orientation_G1 = textread('RiG1.txt');initial_orientation_G1(1:24) = []; initial_orientation_G2 = textread('RiG2.txt'); initial_orientation_G2(1:24) = [];
target_orientation_G1 = textread('RfG1.txt'); target_orientation_G1(1:24) = []; target_orientation_G2 = textread('RfG2.txt'); target_orientation_G2(1:24) = [];

% organize data according to factors - group 2
initial_orientation = initial_orientation_G2;
target_orientation = target_orientation_G2; 
rotation_axis = intrinsic_axis_G2 + extrinsic_axis_G2;
alignment = double(rotation_axis<=3) + 2*double(rotation_axis>=4);
frame = double(intrinsic_axis_G2~=0) + 2*double(extrinsic_axis_G2~=0);
factors = [initial_orientation,target_orientation,alignment,frame,rotation_axis];

Nrep = 8;
Ncomb = Ntr/Nrep;
yy = nan(Np,Ncomb*Nrep);
for pNum = 1:Np/2
    index = nan(Ntr,1);
    thisData = QGS(pNum,:);
    withinMat = categorical(table2array(within));
    counter = zeros(Ncomb,1);
    w = nan(Ncomb,Nrep);
    for trNum = 1:Ntr
        thisComb = categorical(factors(trNum,:));
        thisY = thisData(trNum);
        [~,index(trNum)] = ismember(thisComb,withinMat,'rows');
        counter(index(trNum)) = counter(index(trNum)) + 1;       
        w(index(trNum),counter(index(trNum))) = thisY;
    end
    yy(pNum,:) = reshape(w,1,Ntr);
end

% organize data according to factors - group 1
initial_orientation = initial_orientation_G1;
target_orientation = target_orientation_G1; 
rotation_axis = intrinsic_axis_G1 + extrinsic_axis_G1;
alignment = double(rotation_axis<=3) + 2*double(rotation_axis>=4);
frame = double(intrinsic_axis_G1~=0) + 2*double(extrinsic_axis_G1~=0);
factors = [initial_orientation,target_orientation,alignment,frame,rotation_axis];
combs = table2array(within);
for pNum = (Np/2+1):Np
    thisData = QGS(pNum,:);
    withinMat = categorical(table2array(within));
    counter = zeros(Ncomb,1);
    w = nan(Ncomb,8);
    for trNum = 1:Ntr
        thisComb = categorical(factors(trNum,:));
        thisY = thisData(trNum);
        [~,index(trNum)] = ismember(thisComb,withinMat,'rows');
        counter(index(trNum)) = counter(index(trNum)) + 1;       
        w(index(trNum),counter(index(trNum))) = thisY;
    end
    yy(pNum,:) = reshape(w,1,Ntr);
end

% repeated measures ANOVA
y = log10(yy);
between = [table(group),array2table(y)];
rm = fitrm(between,'y1-y384 ~ group','WithinDesign',repmat(within,8,1));
[ranovatbl,~,~,~] = ranova(rm,'WithinModel','initial_orientation + target_orientation + alignment + frame + rotation_axis');

ranovatbl.eta2 = nan(18,1);
for i=[2,5,8,11,14,17]
    ranovatbl.eta2(i) = ranovatbl.SumSq(i)/(ranovatbl.SumSq(i)+ranovatbl.SumSq(i+1));
end
for i=[4,7,10,13,16]
    ranovatbl.eta2(i) = ranovatbl.SumSq(i)/(ranovatbl.SumSq(i)+ranovatbl.SumSq(i+2));
end   
end