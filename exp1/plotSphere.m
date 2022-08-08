function [] = plotSphere()
%% Plot a full grey sphere
hold on
[x_s,y_s,z_s] = sphere(15);
h = surf(x_s,y_s,z_s);
h.EdgeColor = 'None';
set(h, 'FaceAlpha', 0.4)
hidden off
axis equal
axis off
map = repmat((linspace(1,0,100))',1,3);
colormap(map)
h.EdgeColor = 'interp';
end

