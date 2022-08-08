function QGS_BL = baseline_QGS()
set(0,'defaultfigureposition',get(0, 'Screensize')-[-10,-10,100,100]);
set(0,'defaultTextFontSize',15);
set(0,'defaultTextFontName','Times');
set(0,'defaultAxesFontName','Times');
set(0,'defaultAxesFontSize',15);
set(0,'defaultLineLineWidth',1);
set(0,'defaultAxesTickLabelInterpreter','tex');
set(0,'defaultLegendInterpreter','tex');
set(0,'defaultTextInterpreter','tex');

clear
clc

load exp2data.mat;

inits = {'IM','YB','ST','IK','EM','RB','DC','SS','SA','BS'... % group 1 - extrinsic
    'ZC','SO','LT','IA','MG','IY','YL','AO','SD','TT'... % group 2 - intrinsic
    'YBI','NI','IR','HG','HR','EZ','OS','GS','ET','AF'}; % group 3 - control

QGS_BL = nan(length(inits),120);
indpeak = nan(length(inits),120);

for sub=1:length(inits)
    for trNum = 60:179 % only BL trials
        if isfield(exp2data.(inits{sub}),['trial',num2str(trNum)])
            take = exp2data.(inits{sub}).(['trial',num2str(trNum)]).subSegments(1,1):length(exp2data.(inits{sub}).(['trial',num2str(trNum)]).quaternion);
            [~,indpeak(sub,trNum-59)] = nanmax(exp2data.(inits{sub}).(['trial',num2str(trNum)]).angularSpeed(take));
          
            q = exp2data.(inits{sub}).(['trial',num2str(trNum)]).quaternion(take(1):(take(1)+indpeak(sub,trNum-59)-1),:);
            QGS_BL(sub,trNum-59) = geodicityFactor(q);
        end
    end
end

for gr = 1:3
    part = [1:10] + 10*(gr-1);
    thisQGS = QGS_BL(part,:);
    med = nanmedian(thisQGS(:));
    [bootstat,~] = bootstrp(1E3,@nanmedian,thisQGS(:));
    ci = quantile(bootstat,[(1-0.95)/2,(1+0.95)/2]);
    P = [prctile(thisQGS(:),25), prctile(thisQGS(:),75)];

    fprintf(['group ',num2str(gr),': median = ',num2str(med),', ci = [',num2str(ci(1)),',',num2str(ci(2)),']',', ','percentile = [',num2str(P(1)),',',num2str(P(2)),']\n'])
end
end