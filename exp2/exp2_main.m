clear
clc
close all
addpath(genpath([cd,'\text files exp 2']))
addpath(genpath([cd,'\data files exp 2']))
addpath(genpath('D:\VMR_data'))
%% Read text files and process data
subStrs = {'IM_2021_04_05','YB_2021_04_05','ST_2021_03_21','IK_2021_03_24','EM_2021_03_24','RB_2021_08_09','DC_2021_08_10','SS_2021_08_10','SA_2021_08_10','BS_2021_08_16'... % group 1 - extrinsic
    'ZC_2021_03_21','SO_2021_03_24','LT_2021_04_05','IA_2021_04_05','MG_2021_04_05','IY_2021_04_26','YL_2021_08_01','AO_2021_08_03','SD_2021_08_04','TT_2021_08_16'... % group 2 - intrinsic
    'YBI_2021_04_06','NI_2021_04_07','IR_2021_04_06','HG_2021_04_06','HR_2021_04_07','EZ_2021_07_28','OS_2021_07_29','GS_2021_07_29','ET_2021_07_29','AF_2021_08_01'}; % group 3 - control
groups = [1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,3,3,3,3];
inits = {'IM','YB','ST','IK','EM','RB','DC','SS','SA','BS'... % group 1 - extrinsic
    'ZC','SO','LT','IA','MG','IY','YL','AO','SD','TT'... % group 2 - intrinsic
    'YBI','NI','IR','HG','HR','EZ','OS','GS','ET','AF'}; % group 3 - control
Ntrials = 420;
numSubs = length(subStrs);

% delete trials
% group 1 - extrinsic
trials2delete{1} = []+1; % IM
trials2delete{2} = [30,185,277,308,393]+1; % YB
trials2delete{3} = [38,40,46,48,49,53,57,58]+1; % ST
trials2delete{4} = [30,71]+1; % IK
trials2delete{5} = [30,120,416]+1; % EM
trials2delete{6} = []+1; % RB
trials2delete{7} = []+1; % DC
trials2delete{8} = []+1; % SS
trials2delete{9} = []+1; % SA
trials2delete{10} = []+1; % BS
% group 2 - intrinsic
trials2delete{11} = []+1; % ZC
trials2delete{12} = [369,415]+1; % SO
trials2delete{13} = []+1; % LT
trials2delete{14} = []+1; % IA
trials2delete{15} = [204]+1; % MG
trials2delete{16} = [60,418]+1; % IY
trials2delete{17} = [120,160]+1; % YL
trials2delete{18} = []+1; % AO
trials2delete{19} = [126,291]+1; % SD
trials2delete{20} = []+1; % TT
% group 3 - control
trials2delete{21} = [382]+1; % YBI
trials2delete{22} = [120]+1; % NI
trials2delete{23} = [116,201]+1; % IR
trials2delete{24} = [202]+1; % HG
trials2delete{25} = []+1; % HR
trials2delete{26} = [247]+1; % EZ
trials2delete{27} = [60,392,398]+1; % OS
trials2delete{28} = []+1; % GS
trials2delete{29} = []+1; % ET
trials2delete{30} = []+1; % AF

keepTrials = cell(1,numSubs);
for subNum = 1:numSubs
    keepTrials{subNum} = 0:419;
    keepTrials{subNum}(trials2delete{subNum}) = [];
end

for subNum = 1:numSubs
    subStr = subStrs{subNum};
    initials = inits{subNum};
    group = groups(subNum);
    for trNum = 0:419
        if ismember(trNum,keepTrials{subNum})
            exp2data.(initials).(['trial',num2str(trNum)]) = trFunction_exp2(subStr,trNum,group);
            sprintf(['subject ',initials,', ','trial ',num2str(trNum)])
        end
    end    
end

[KnoBLmean1,Kgroup1,KnoBLmean_FML1,KnoBL_FML1] = groupAxes(exp2data,inits(groups==1),1,keepTrials(groups==1));
[KnoBLmean2,Kgroup2,KnoBLmean_FML2,KnoBL_FML2] = groupAxes(exp2data,inits(groups==2),2,keepTrials(groups==2));
[KnoBLmean3,Kgroup3,KnoBLmean_FML3,KnoBL_FML3] = groupAxes(exp2data,inits(groups==3),3,keepTrials(groups==3));
[errnoBLG1,M1,S1,ERR1,M_FML1,S_FML1,ERR_FML1] = groupAngles(exp2data,inits(groups==1),1,keepTrials(groups==1));
[errnoBLG2,M2,S2,ERR2,M_FML2,S_FML2,ERR_FML2] = groupAngles(exp2data,inits(groups==2),2,keepTrials(groups==2));
[errnoBLG3,M3,S3,ERR3,M_FML3,S_FML3,ERR_FML3] = groupAngles(exp2data,inits(groups==3),3,keepTrials(groups==3));

Ks = {KnoBLmean1,KnoBLmean2,KnoBLmean3};
M = {M1,M2,M3};
S = {S1,S2,S3};
ERR = {-ERR1,-ERR2,-ERR3};

Ks_FML = {KnoBLmean_FML1,KnoBLmean_FML2,KnoBLmean_FML3};
M_FML = {M_FML1,M_FML2,M_FML3};
S_FML = {S_FML1,S_FML2,S_FML3};
ERR_FML = {ERR_FML1,ERR_FML2,ERR_FML3};

for i=1:3
    rotation_axes(:,:,i) = Ks{i};
    hand_angle(:,:,i) = ERR{i};
    mean_hand_angle(i,:) = M{i};
    sigma(i,:) = S{i};

    rotation_axes_FML(:,:,i) = Ks_FML{i};
    hand_angle_FML(:,:,i) = ERR_FML{i};
    mean_hand_angle_FML(i,:) = M_FML{i};
    sigma_FML(i,:) = S_FML{i};
end
exp2plotdata.hand_angle = hand_angle;
exp2plotdata.rotation_axes = rotation_axes;
exp2plotdata.mean_hand_angle = mean_hand_angle;
exp2plotdata.sigma = sigma;
exp2plotdata_FML.hand_angle = hand_angle_FML;
exp2plotdata_FML.rotation_axes = rotation_axes_FML;
exp2plotdata_FML.mean_hand_angle = mean_hand_angle_FML;
exp2plotdata_FML.sigma = sigma_FML;

% uncomment to save processed data
% save('exp2data.mat','exp2data');
% save('exp2plotdata.mat','exp2plotdata');
% save('exp2plotdata_FML.mat','exp2plotdata_FML');
% save('Kgroup1.mat','Kgroup1')
% save('Kgroup2.mat','Kgroup2')
% save('Kgroup3.mat','Kgroup3')

% uncomment to load data without generating it
% load exp2data.mat
% load exp2plotdata.mat
% load exp2plotdata_FML.mat
% load Kgroup1.mat
% load Kgroup2.mat
% load Kgroup3.mat


%% Statistics
% generate text files for the spherical statistis or use the files given
for tr=1:10
    generateTXTfiles(Kgroup1,Kgroup2,Kgroup3,tr)
end
mean_difference_spherical_analysis()
qgs_baseline = baseline_QGS();
% To see the spherical statistics, see 'exp2_spherical_statistics.R'
% The "Directional" package is required in order to run the code.

% scalar aiming angles statistics
for tr=1:10
    multiple_trials = exp2_statistics(tr);
end
%% Figures
% Fig. 8 - Aiming axes and angles of a single participant in the Extrinsic group
exp2_example()
% Fig. 9 - Within and between groups spherical analysis
exp2_spherical_analysis()
% Fig. 10 - Comparison of angular velocity profiles at key stages
exp2_velocity_analysis()
% Fig. 11 - Average aiming axes and angles of all groups in experiment 2 and comparisons between and within groups of the aiming angles
exp2_results()