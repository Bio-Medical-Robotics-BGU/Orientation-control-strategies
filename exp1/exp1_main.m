clear
clc
close all
addpath(genpath([cd,'\text files exp 1']))
addpath(genpath([cd,'\data files exp 1']))

%% Read text files and process data
subStrs = {'NC_2021_02_25','RS_2021_02_24','MG_2021_02_25','IN_2021_02_25','MG_2021_02_22','EY_2021_02_22','BO_2021_02_22',...
    'OG_2021_02_18','MK_2021_02_18','MN_2021_02_18','RG_2021_02_15','GO_2021_02_15','OT_2021_02_15','YB_2021_02_28'};
groups = [2,2,2,2,2,2,2,1,1,1,1,1,1,1];
inits = {'NC','RS','MGA','IN','MG','EY','BO','OG','MK','MN','RG','GO','OT','YB'};
Ntrials = 408;
numSubs = length(subStrs);

trials2delete{1} = [4,35,146,197,229,213]+1;
trials2delete{2} = [111,126,164,198,307,309,236,343,281]+1;
trials2delete{3} = [348]+1;
trials2delete{4} = [309]+1;
trials2delete{5} = []+1;
trials2delete{6} = [72,164,321]+1;
trials2delete{7} = [24,164]+1;
trials2delete{8} = [92,198,261,281]+1;
trials2delete{9} = []+1;
trials2delete{10} = [130]+1;
trials2delete{11} = [65,66,292,380]+1;
trials2delete{12} = [4,44,45,112,161]+1;
trials2delete{13} = []+1;
trials2delete{14} = [28,51,264]+1;

for subNum = 1:numSubs
    trials{subNum} = 0:407;
    trials{subNum}(trials2delete{subNum}) = [];
end

QGS = nan(14,384);
for subNum = 1:numSubs
    
    initials = inits{subNum};
    subStr = subStrs{subNum};
    group = groups(subNum);
    
    for trNum = 24:(Ntrials-1)
        if ismember(trNum,trials{subNum})
            exp1data.(initials).(['trial',num2str(trNum)]) = trFunction_exp1(subStr,trNum,group);
            sprintf(['participant ',initials,', trial ',num2str(trNum),': QGS=',num2str(exp1data.(initials).(['trial',num2str(trNum)]).QGS)])
            QGS(subNum,trNum-23) = exp1data.(initials).(['trial',num2str(trNum)]).QGS;
        end
    end
end

% uncomment to save processed data
% save('exp1_QGS.mat','QGS')
% save('exp1data.mat','exp1data')
%% Statistics
ranova = exp1_statistics();
%% Create figures
% Fig5 - Representative examples of a geodesic and a non-geodesic
h5 = generateFig5();
% Fig6 - Median QGS and 95% CI
h6 = generateFig6();


