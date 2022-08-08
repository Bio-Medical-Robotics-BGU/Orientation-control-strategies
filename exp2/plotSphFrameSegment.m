function [] = plotSphFrameSegment
    hold on
    [x_s,y_s,z_s] = sphere(35);
    
    [az,el,r] = cart2sph(x_s,y_s,z_s);
    el(el<deg2rad(-30)) = NaN;el(el>deg2rad(30)) = NaN;
    az(el<deg2rad(-30)) = NaN;az(el>deg2rad(30)) = NaN;
    az(az<deg2rad(-70)) = NaN;az(az>deg2rad(120)) = NaN;
    el(az<deg2rad(-70)) = NaN;el(az>deg2rad(120)) = NaN;
    [x_s,y_s,z_s] = sph2cart(az,el,r);
    
    h = surf(x_s,y_s,z_s);
    h.EdgeColor = 'None';
    set(h, 'FaceAlpha', 0.4)
    hidden off
    axis equal
    axis off
    map = repmat(linspace(1,0,100)',1,3);
    colormap(map)
    h.EdgeColor = 'interp';
    view(115,15)
end