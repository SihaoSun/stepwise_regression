function [k,y] = OLS(X,z)
% Original least square method by using scaled and centered regressors.
% X : matrix with n regressors as columns
% z : measurement, N*1 demension vector
% k : estimated parameters
% y : model output

[N,n] = size(X);
p = n -1;
Sjj = ones(p,1);
Szz = sum((z-mean(z)).^2);
zs = (z-mean(z))/sqrt(Szz);
As = zeros(N,p);

for j=1:p
    Sjj(j) = sum((X(:,j+1)-mean(X(:,j+1))).^2);
    As(:,j) = (X(:,j+1)-mean(X(:,j+1)))/sqrt(Sjj(j));
end
ks = (As'*As)\As'*zs;
% Cs = inv(As'*As);

k = [mean(z)-mean(X(:,2:end),1)*(ks.*sqrt(Szz./Sjj));ks.*sqrt(Szz./Sjj)];
y = X*k;
end