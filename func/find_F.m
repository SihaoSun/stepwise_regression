function F = find_F(X,z)
%% Compute F_p for F-test
% X : matrix with n regressors as columns
% z : measurement, N*1 demension vector
% reference: 
%   [1]T. Lombaerts "Fault Tolerant Flight Control,a Physical Model Approach" 
%      chapter 5.2.2 p167
% Sihao Sun 30-Jan-2016
% S.Sun-4@tudelft.nl

[N,p] = size(X);

theta = (X'*X)\X'*z;
RSS = sum((z-X*theta).^2);
Cov = inv(X'*X)*RSS/(N-p);
s2 = diag(Cov);

F = theta.^2./s2;

end