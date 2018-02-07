function [F0,in] = forward_selection(X,A,z,Fin,j)
%% Forward slection using F test.
% X: Candidate regressors
% A: Regressors including bias term as the first column ,(N*np) matrix
% z: Measurement, N*1 vector
% Fin: If F0>Fin, eliminate the corresponding regressor
% j: Index of the regressor with maximum F0
% F0: F0 value of the above regressor
% in: Bool value indicating if select the above regressor
%
% Sihao Sun 31-Jan-2017
% S.Sun-4@tudelft.nl


[N,np] = size(A);
[nx] = size(X,2);

F = zeros(nx,1);
for jj = j
XX = [A,X(:,jj)];
k0 = OLS(XX,z);
% k0 = (XX'*XX)\XX'*z;
y0 = XX*k0;
SS0 = k0'*XX'*z-N*mean(z)^2;

XX = A;
k1 = OLS(XX,z);
% k1 = (XX'*XX)\XX'*z;
y1 = XX*k1;
SS1 = k1'*XX'*z-N*mean(z)^2;

s2 = sum((z-y0).^2)/(N-np-1);

F(jj) = (SS0-SS1)/s2;
end

[F0,i] = max(abs(F));
if F0>Fin
    in = true;
else
    in = false;
end
end