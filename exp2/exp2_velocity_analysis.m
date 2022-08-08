function exp2_velocity_analysis()

set(0,'defaultfigureposition',get(0, 'Screensize')-[-10,-10,100,100]);
set(0,'defaultTextFontSize',15);
set(0,'defaultTextFontName','Times');
set(0,'defaultAxesFontName','Times');
set(0,'defaultAxesFontSize',15);
set(0,'defaultLineLineWidth',1);
set(0,'defaultAxesTickLabelInterpreter','tex');
set(0,'defaultLegendInterpreter','tex');
set(0,'defaultTextInterpreter','tex');

load('exp2data.mat')
dark = [0.105882352941176,0.619607843137255,0.466666666666667;0.850980392156863,0.372549019607843,0.00784313725490196;0.458823529411765,0.439215686274510,0.701960784313725;0.905882352941177,0.160784313725490,0.541176470588235];
cBL1 = dark(1,:);
cBL2 = dark(2,:);
cTRN = dark(3,:);
cTFR = dark(4,:);
h = figure('Renderer', 'Painters');
set(h,'Units','normalized')
set(h, 'Position',  [0.1823    0.1198    0.4817    0.5521])
set(h,'Color',[1 1 1]);
set(h,'windowState','maximized')
hold on
axis off
key = [119,179,180,359,360,419];
titles = {'Late BL1','Late BL2','Early TRN','Late TRN','Early TFR','Late TFR'};

m = [159,154,1268,138,249,151,251,189,639,169,223,193,163,169,1169,292,372,147];
pos = [0.1 0.7 0.13 0.25;
       0.25 0.7 0.13 0.25;
       0.4 0.7 0.13 0.25;
       0.55 0.7 0.13 0.25;
       0.7 0.7 0.13 0.25;
       0.85 0.7 0.13 0.25;
       0.1 0.43 0.13 0.25;
       0.25 0.43 0.13 0.25;
       0.4 0.43 0.13 0.25;
       0.55 0.43 0.13 0.25;
       0.7 0.43 0.13 0.25;
       0.85 0.43 0.13 0.25;
       0.1 0.16 0.13 0.25;
       0.25 0.16 0.13 0.25;
       0.4 0.16 0.13 0.25;
       0.55 0.16 0.13 0.25;
       0.7 0.16 0.13 0.25;
       0.85 0.16 0.13 0.25];
co = [cBL1;cBL2;cTRN;cTRN;cTFR;cTFR];      
for gr = 1:3
    subs = inits([1:10] + (gr-1)*10);
    for i=1:6  
        axes('Position',pos(i+(gr-1)*6,:))
        set(gca,'xcolor',co(i,:),'ycolor',co(i,:),'LineWidth',2)
        tr = key(i);
        if tr==180 || tr == 360
            tr2 = [tr,tr+1,tr+2];
        else
            tr2 = [tr,tr-1,tr-2];
        end

        vel_res = nan(m(i+(gr-1)*6)-1,3,10);
        hold on
        for s=1:10
            sub =subs{s};
         
            mm = 1;
            res = nan(m(i+(gr-1)*6)-1,3,3);
            for ntr = tr2
                if isfield(exp2data.(sub),['trial',num2str(ntr)])
                    speed = exp2data.(sub).(['trial',num2str(ntr)]).angularSpeed;
                    lowSpeed = find(speed>=0.25,1,'last');
                    quat = exp2data.(sub).(['trial',num2str(ntr)]).quaternion;
                    take = exp2data.(sub).(['trial',num2str(ntr)]).subSegments(1,1):lowSpeed;
                    quat = quat(take,:);
                    time = 0:0.01:0.01*(length(quat)-1);
                    vel = quat2angvel(quat,time','intrinsic');
                    res(1:length(resample(vel,m(i+(gr-1)*6),length(quat))),:,mm) =...
                        resample(vel,m(i+(gr-1)*6),length(quat));    
                end
                mm = mm + 1;
            end
            res = nanmean(res,3);
            vel_res(1:length(res),:,s) = res;

            time = linspace(0,1,length(res));
            px = plot(time,res(:,1),'Color','#0072BD','LineWidth',0.5);
            px.Color(4) = 0.3;
            py = plot(time,res(:,2),'Color','#D95319','LineWidth',0.5);
            py.Color(4) = 0.3;
            pz = plot(time,res(:,3),'Color','#EDB120','LineWidth',0.5);
            pz.Color(4) = 0.3;

            pw = plot(time,vecnorm(res')','Color','k','LineWidth',0.5,'LineStyle','--');
            pw.Color(4) = 0.3;
        end
        vel_avg = nanmean(vel_res,3);
        time = linspace(0,1,length(vel_avg));
        
        px = plot(time,vel_avg(:,1),'Color','#0072BD','LineWidth',2);
        py = plot(time,vel_avg(:,2),'Color','#D95319','LineWidth',2);
        pz = plot(time,vel_avg(:,3),'Color','#EDB120','LineWidth',2);
        pw = plot(time,vecnorm(vel_avg')','Color','k','LineWidth',2,'LineStyle','--');
        pw.Color(4) = 1;
        xlim([0 1])
        ylim([-7 10])
        
        if i==1 && gr ==1
            legend([px py pz pw],...
                {'$\mathrm{\omega_x}$','$\mathrm{\omega_y}$','$\mathrm{\omega_z}$','$\mathrm{||\mathbf{\omega}||}$'},...
                'Interpreter','latex','box','off')
        end
        if i==1 || i==7 || i==13
            yticks([-6,-3,0,3,6,9])
            ticklabels = get(gca,'YTickLabel');
            ticklabels_new = cell(size(ticklabels));
            for k = 1:length(ticklabels)
                ticklabels_new{k} = ['\color{black} ' ticklabels{k}];
            end
            set(gca, 'YTickLabel', ticklabels_new);
        else
            yticks([])
        end
        if gr==3 && i==3
            xl = xlabel('\color{black}Normalized Time');
            xl.Position(1) = 1.1;
            
        end
        if gr==3
            xticks([0 1])
            ticklabels = get(gca,'XTickLabel');
            ticklabels_new = cell(size(ticklabels));
            for k = 1:length(ticklabels)
                ticklabels_new{k} = ['\color{black} ' ticklabels{k}];
            end
            set(gca, 'XTickLabel', ticklabels_new);
        else
            xticks([])
        end
        if i==1 && gr == 2
            yl = ylabel('\color{black}Angular Velocity [rad/s]');
        end
        if gr == 1 
            title(titles{i},'FontWeight','normal')
        end
        box on
    end
end

axes('Position',[0.02 0.28 0.1 0.55]);
text(0,1,{'Extrinsic',' Group'})
text(0,0.5,{'Intrinsic',' Group'})
text(0,0,{'Control',' Group'})
axis off

axes('Position',[0.00 0.4 0.1 0.55]);
text(0,1,{'(a)'})
text(0,0.5,{'(b)'})
text(0,0,{'(c)'})
axis off

% exportgraphics(gcf,'exp2_velocity_analysis.pdf','Resolution',300,'ContentType','vector','BackgroundColor','none')    
end