function drawArc(qinits,qfinals,c)
    for i=1:size(qinits,1)
        qinit = qinits(i,:);
        qfinal = qfinals(i,:);
        aa = [linspace(qinit(1),qfinal(1),100)',linspace(qinit(2),qfinal(2),100)',linspace(qinit(3),qfinal(3),100)'];
        aa_unit = aa./repmat(vecnorm(aa')',1,3);
        plot3(aa_unit(:,1),aa_unit(:,2),aa_unit(:,3),c,'LineWidth',1)
    end
end