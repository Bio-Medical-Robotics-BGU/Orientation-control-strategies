function multiple_trials = exp2_statistics(numTrials)

load('exp2plotdata.mat')
hand_angle = exp2plotdata.hand_angle;
keytrials = [60 120 121 300 301 360];

for key=1:length(keytrials)
    if ismember(keytrials(key),[121,301])
        hand_angle(:,keytrials(key),:) = nanmean(hand_angle(:,keytrials(key):(keytrials(key)+(numTrials-1)),:),2);
    else
        hand_angle(:,keytrials(key),:) = nanmean(hand_angle(:,(keytrials(key)-(numTrials-1)):keytrials(key),:),2);
    end
end
y = [hand_angle(:,keytrials,1);hand_angle(:,keytrials,2);hand_angle(:,keytrials,3)];

Y = array2table(y);
G = array2table([repmat({'G1'},10,1);repmat({'G2'},10,1);repmat({'G3'},10,1)],'variablenames',{'Groups'});
T1 = [G Y];
W1 = array2table([{'BL1'};{'BL2'};{'EA'};{'LA'};{'EW'};{'LW'}],'variablenames',{'trial'});
W1.trial = categorical(W1.trial);
rm_model = fitrm(T1,'y1-y6~Groups','WithinDesign',W1);
tbl = ranova(rm_model,'WithinModel','trial');
tbl.eta2 = nan(6,1); 
tbl.eta2(2) = tbl.SumSq(2)/(tbl.SumSq(2)+tbl.SumSq(3)); 
tbl.eta2(4) = tbl.SumSq(4)/(tbl.SumSq(4)+tbl.SumSq(6));
tbl.eta2(5) = tbl.SumSq(5)/(tbl.SumSq(5)+tbl.SumSq(6));

groupBytrial = multcompare(rm_model,'Groups','by','trial','ComparisonType','Bonferroni');
trialBygroup = multcompare(rm_model,'trial','by','Groups','ComparisonType','Bonferroni');
compareGroups = multcompare(rm_model,'Groups','ComparisonType','Bonferroni');
comparetrials = multcompare(rm_model,'trial','ComparisonType','Bonferroni');

sBg = [trialBygroup([2,32,62],:);trialBygroup([4,34,64],:)...
    ;trialBygroup([8,38,68],:);trialBygroup([10,40,70],:)...
    ;trialBygroup([14,44,74],:);trialBygroup([20,50,80],:)];
sBg.tstat = sBg.Difference./sBg.StdErr;
gBs = [groupBytrial([1,2,4],:);groupBytrial([7,8,10],:)...
    ;groupBytrial([13,14,16],:);groupBytrial([19,20,22],:)...
    ;groupBytrial([25,26,28],:);groupBytrial([31,32,34],:)];
gBs.tstat = gBs.Difference./gBs.StdErr;

multiple_trials = struct('anovatbl',[],'multcomparisons',[],'effectsize',[]);
multiple_trials.multcomparisons = struct('stageBygroup',sBg,'groupBystage',gBs);
multiple_trials.anovatbl = tbl;
multiple_trials.effectsize = table('Size',[3 12],'VariableTypes',{'double','double','double','double','double','double','double','double','double','double','double','double'},...
    'VariableNames',{'60_121','121_300','120_301','301_360','120_360','301','360','60','120','121','300','60_300'});
% trial 60 and 121
dext = abs(effectSize_Cohen_d(Y.y1(1:10),Y.y3(1:10),1));
dint = abs(effectSize_Cohen_d(Y.y1(11:20),Y.y3(11:20),1));
dcon = abs(effectSize_Cohen_d(Y.y1(21:30),Y.y3(21:30),1));
multiple_trials.effectsize(:,1) = array2table([dext;dint;dcon]);
% trial 121 and 300
dext = abs(effectSize_Cohen_d(Y.y3(1:10),Y.y4(1:10),1));
dint = abs(effectSize_Cohen_d(Y.y3(11:20),Y.y4(11:20),1));
dcon = abs(effectSize_Cohen_d(Y.y3(21:30),Y.y4(21:30),1));
multiple_trials.effectsize(:,2) = array2table([dext;dint;dcon]);
% trial 120 and 301
dext = abs(effectSize_Cohen_d(Y.y2(1:10),Y.y5(1:10),1));
dint = abs(effectSize_Cohen_d(Y.y2(11:20),Y.y5(11:20),1));
dcon = abs(effectSize_Cohen_d(Y.y2(21:30),Y.y5(21:30),1));
multiple_trials.effectsize(:,3) = array2table([dext;dint;dcon]);
% trial 301 and 360
dext = abs(effectSize_Cohen_d(Y.y5(1:10),Y.y6(1:10),1));
dint = abs(effectSize_Cohen_d(Y.y5(11:20),Y.y6(11:20),1));
dcon = abs(effectSize_Cohen_d(Y.y5(21:30),Y.y6(21:30),1));
multiple_trials.effectsize(:,4) = array2table([dext;dint;dcon]);

% trial 60 and 300
dext = abs(effectSize_Cohen_d(Y.y1(1:10),Y.y4(1:10),1));
dint = abs(effectSize_Cohen_d(Y.y1(11:20),Y.y4(11:20),1));
dcon = abs(effectSize_Cohen_d(Y.y1(21:30),Y.y4(21:30),1));
multiple_trials.effectsize(:,12) = array2table([dext;dint;dcon]);

% trial 120 and 360
dext = abs(effectSize_Cohen_d(Y.y2(1:10),Y.y6(1:10),1));
dint = abs(effectSize_Cohen_d(Y.y2(11:20),Y.y6(11:20),1));
dcon = abs(effectSize_Cohen_d(Y.y2(21:30),Y.y6(21:30),1));
multiple_trials.effectsize(:,5) = array2table([dext;dint;dcon]);
% trial 301
d12 = abs(effectSize_Cohen_d(Y.y5(1:10),Y.y5(11:20),0));
d13 = abs(effectSize_Cohen_d(Y.y5(1:10),Y.y5(21:30),0));
d23 = abs(effectSize_Cohen_d(Y.y5(11:20),Y.y5(21:30),0));
multiple_trials.effectsize(:,6) = array2table([d12;d13;d23]);
% trial 360
d12 = abs(effectSize_Cohen_d(Y.y6(1:10),Y.y6(11:20),0));
d13 = abs(effectSize_Cohen_d(Y.y6(1:10),Y.y6(21:30),0));
d23 = abs(effectSize_Cohen_d(Y.y6(11:20),Y.y6(21:30),0));
multiple_trials.effectsize(:,7) = array2table([d12;d13;d23]);
% trial 60
d12 = abs(effectSize_Cohen_d(Y.y1(1:10),Y.y1(11:20),0));
d13 = abs(effectSize_Cohen_d(Y.y1(1:10),Y.y1(21:30),0));
d23 = abs(effectSize_Cohen_d(Y.y1(11:20),Y.y1(21:30),0));
multiple_trials.effectsize(:,8) = array2table([d12;d13;d23]);
% trial 120
d12 = abs(effectSize_Cohen_d(Y.y2(1:10),Y.y2(11:20),0));
d13 = abs(effectSize_Cohen_d(Y.y2(1:10),Y.y2(21:30),0));
d23 = abs(effectSize_Cohen_d(Y.y2(11:20),Y.y2(21:30),0));
multiple_trials.effectsize(:,9) = array2table([d12;d13;d23]);
% trial 121
d12 = abs(effectSize_Cohen_d(Y.y3(1:10),Y.y3(11:20),0));
d13 = abs(effectSize_Cohen_d(Y.y3(1:10),Y.y3(21:30),0));
d23 = abs(effectSize_Cohen_d(Y.y3(11:20),Y.y3(21:30),0));
multiple_trials.effectsize(:,10) = array2table([d12;d13;d23]);
% trial 300
d12 = abs(effectSize_Cohen_d(Y.y4(1:10),Y.y4(11:20),0));
d13 = abs(effectSize_Cohen_d(Y.y4(1:10),Y.y4(21:30),0));
d23 = abs(effectSize_Cohen_d(Y.y4(11:20),Y.y4(21:30),0));
multiple_trials.effectsize(:,11) = array2table([d12;d13;d23]);

end