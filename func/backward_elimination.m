function [j,F0,out] = backward_elimination(A,z,Fout)
%% backward elimination using F test.
% A: Regressors including bias term as the first column ,(N*np) matrix
% z: Measurement, N*1 vector
% Fout: If F0<Fout, eliminate the corresponding regressor
% j: Index of the regressor with minimum F0
% F0: F0 value of the above regressor
% out: Bool value indicating if eliminate the above regressor
%
% Sihao Sun 31-Jan-2017
% S.Sun-4@tudelft.nl


[N,np] = size(A);

F = inf(np,1);
for jj = 2:np
X = A;
k0 = OLS(X,z);
% k0 = (X'*X)\X'*z;
y0 = X*k0;
SS0 = k0'*X'*z-N*mean(z)^2;

X(:,jj) = [];
k1 = OLS(X,z);
% k1 = (X'*X)\X'*z;
y1 = X*k1;
SS1 = k1'*X'*z-N*mean(z)^2;

s2 = sum((z-y0).^2)/(N-np);

F(jj) = (SS0-SS1)/s2;
end

[F0,j] = min(abs(F));
if F0<Fout
    out = true;
else
    out = false;
end
end