function mean_difference_spherical_analysis()
set(0,'defaultfigureposition',get(0, 'Screensize')-[-10,-10,100,100]);
set(0,'defaultTextFontSize',10);
set(0,'defaultTextFontName','Times');
set(0,'defaultAxesFontName','Times');
set(0,'defaultAxesFontSize',10);
set(0,'defaultLineLineWidth',1);
set(0,'defaultAxesTickLabelInterpreter','tex');
set(0,'defaultLegendInterpreter','tex');
set(0,'defaultTextInterpreter','tex');

clear
clc

load Kgroup1
load Kgroup2
load Kgroup3
Kgroups = {Kgroup1,Kgroup2,Kgroup3};

% within groups comparisons

comp = [60 121;121 300;60 300;120 301;300 301;301 360;120 360];
for c = 1:size(comp,1)
    fprintf(['\n######## ',num2str(comp(c,1)),' vs. ',num2str(comp(c,2)),' ########\n'])
    for gr = 1:3
        if c == 5 && gr ~= 1
            continue
        end

        for numTrials = 1:10
            
            samp1 = spherical_sensetivity_analysis(comp(c,1),Kgroups{gr},numTrials);
            samp2 = spherical_sensetivity_analysis(comp(c,2),Kgroups{gr},numTrials);

            % rotation in special cases
            if c == 3
                for i=1:size(samp1,1)
                    samp1(i,:) = (rotx(-60)*samp1(i,:)')';
                end
            elseif c == 5
                for i=1:size(samp1,1)
                    samp1(i,:) = (rotx(-90)*samp1(i,:)')';
                end
            end

            m1 = meanDirection3D(samp1);
            m2 = meanDirection3D(samp2);
            fprintf([num2str(round(acosd(dot(m1,m2)),1)),'\n']);
        end
    end
end

% between groups comparisons
grps = [1 2;1 3;2 3];

for gr = 1:size(grps,1)
    for k=[121,300,301]
        for numTrials = 1:10
             samp1 = spherical_sensetivity_analysis(k,Kgroups{grps(gr,1)},numTrials);
             samp2 = spherical_sensetivity_analysis(k,Kgroups{grps(gr,2)},numTrials);

             % rotation in special cases
             if k==121 || k==300
                 if grps(gr,1) == 1
                    for i=1:size(samp1,1)
                        samp1(i,:) = (rotx(-90)*samp1(i,:)')';
                    end
                 end
                 if grps(gr,2) == 1
                    for i=1:size(samp2,1)
                        samp2(i,:) = (rotx(-90)*samp2(i,:)')';
                    end
                 end
             end

             if k==301
                 if grps(gr,1) == 3
                    for i=1:size(samp1,1)
                        samp1(i,:) = (rotx(-90)*samp1(i,:)')';
                    end
                 end
                 if grps(gr,2) == 3
                    for i=1:size(samp2,1)
                        samp2(i,:) = (rotx(-90)*samp2(i,:)')';
                    end
                 end
             end

             m1 = meanDirection3D(samp1);
             m2 = meanDirection3D(samp2);
             fprintf([num2str(round(acosd(dot(m1,m2)),1)),'\n']);
        end
    end
end

%% comparisons of sample mean with the ideal axis


idealBL1 = [[0,-1,1]/sqrt(2);[0,1,1]/sqrt(2);[0,1,1]/sqrt(2)];
idealBL1rot60 = [[0,sqrt(3)-1,sqrt(3)+1]/(2*sqrt(2));[0,sqrt(3)+1,1-sqrt(3)]/(2*sqrt(2));[0,sqrt(3)+1,1-sqrt(3)]/(2*sqrt(2))];
idealBL2 = [[0,1,1]/sqrt(2);[0,1,1]/sqrt(2);[0,-1,1]/sqrt(2)];

% Late BL1 vs. Early TRN
for gr=1:3
    for numTrials = 1:10
    samp = spherical_sensetivity_analysis(121,Kgroups{gr},numTrials);
    fprintf([num2str(round(acosd(dot(idealBL1(gr,:),meanDirection3D(samp)')),2)),'\n'])
    end
end

% Late BL1 vs Late TRN
for gr=1:3
    for numTrials = 1:10
    samp = spherical_sensetivity_analysis(300,Kgroups{gr},numTrials);
    fprintf([num2str(round(acosd(dot(idealBL1rot60(gr,:),meanDirection3D(samp)')),2)),'\n'])
    end
end

% Late BL2 vs. Early TFR
for gr=1:3
    for numTrials = 1:10
    samp = spherical_sensetivity_analysis(301,Kgroups{gr},numTrials);
    fprintf([num2str(round(acosd(dot(idealBL2(gr,:),meanDirection3D(samp)')),2)),'\n'])
    end
end

% Late BL2 vs. Late TFR
for gr=1:3
    for numTrials = 1:10
    samp = spherical_sensetivity_analysis(360,Kgroups{gr},numTrials);
    fprintf([num2str(round(acosd(dot(idealBL2(gr,:),meanDirection3D(samp)')),2)),'\n'])
    end
end

end


function samp = spherical_sensetivity_analysis(trial,Kgroup,numTrials)
    if ismember(trial,[60 120 300 360])
            A = Kgroup((trial-(numTrials-1)):trial,:,:);
    elseif ismember(trial,[121 301])
            A = Kgroup(trial:(trial+(numTrials-1)),:,:);
    end
    
    samp = nan(size(Kgroup,3),3);
    for i=1:size(A,3)
        samp(i,:) = meanDirection3D(A(:,:,i))';
    end
end



