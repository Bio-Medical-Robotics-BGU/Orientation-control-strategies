function Cohen_d = effectSize_Cohen_d(samp1,samp2,paired)

N1 = length(samp1);N2 = length(samp2);
m1 = mean(samp1);m2 = mean(samp2);
var1 = var(samp1);var2 = var(samp2);
meanDiff = m1-m2;

if paired
    s = nanstd(samp1-samp2);
else
    num = (N1 - 1)*var1 + (N2 - 1)*var2;
    den = N1 + N2 -2;
    s = sqrt(num/den);
end

Cohen_d = meanDiff/s;
end