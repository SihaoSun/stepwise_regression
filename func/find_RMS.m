function NRMSD = find_RMS(x,z)
%% Compute nomalized root mean square deviation
% x : model output, 1 demension vector
% z : measurement, 1 demension vector
% Sihao Sun 26-01-2016

NRMSD = rms(x-z)/(max(z)-min(z));

end