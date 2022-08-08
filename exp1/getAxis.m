function intAxis = getAxis(num)
%% Get rotation axis
switch (num)
    case 0
        intAxis = [nan,nan,nan];
    case 1
        intAxis = [-1, 0, 0];
    case 2
        intAxis = [0, -1, 0];
    case 3
        intAxis = [0, 0, 1];
    case 4
        intAxis = [sqrt(2)/2, 0, sqrt(2)/2];
    case 5
        intAxis = [0, -sqrt(2)/2, sqrt(2)/2];
    case 6
        intAxis = [sqrt(2)/2,-sqrt(2)/2,0];
    otherwise
        intAxis = [nan,nan,nan];
end
end