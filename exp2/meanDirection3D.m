function dir = meanDirection3D(data)
    x = data(:,1); y = data(:,2); z = data(:,3);
    num = [nansum(x),nansum(y),nansum(z)]';
    den = sqrt((nansum(x))^2+(nansum(y))^2+(nansum(z))^2);
    if den~=0
        dir = num./den;
    else
        dir = [0 0 0]';
    end
end