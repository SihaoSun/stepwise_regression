function PSE = find_PSE(y,z,p)
%% Compute predicted square error (PSE)
% y : model output, 1 demension vector
% z : measurement, 1 demension vector
% p : number of regressors (except bias term)
% reference: 
%   [1]T. Lombaerts "Fault Tolerant Flight Control,a Physical Model Approach" 
%      chapter 5.2.2 p168
% Sihao Sun 30-01-2016

N = length(z);
e = z-y;
s_max = sum((z-mean(z)).^2)/N;

PSE = e'*e/N + s_max*p/N;
end