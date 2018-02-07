%% Orthogonalized least square
A = [A,X];
PSEtol = 1e-6;
[N,np] = size(A);
p=np-1;
X =  A;
p0 = 1*ones(N,1);
P = [p0,zeros(N,p)]; 
G = diag(ones(1,p+1));
for j = 1:p;
    temp = 0;
    for k = 0:j-1
        G(k+1,j+1) = P(:,k+1)'*X(:,j+1)/(P(:,k+1)'*P(:,k+1));
        temp = temp + G(k+1,j+1)*P(:,k+1);
    end    
    P(:,j+1) = X(:,j+1) -  temp;
end


AP = p0;
a = P'*P\P'*z;
Jp = a.^2.*diag(P'*P); Jp(1) = 0;

PSE_last = inf;
step = 1;
while 1
    [~,j] = max(Jp);
    AP = [AP,P(:,j)];
    [kp,y] = OLS(AP,z);
    ap = length(kp)-1;
    PSE = find_PSE(y,z,ap);
    R2 = find_R2(y,z);
    if PSE<PSEtol || PSE>=PSE_last*0.9 || step >= length(a)-1
        break;
    end
    step = step+1;
    PSE_last = PSE;
    Jp(j) = 0;
end
ii = find(Jp==0, 1, 'last' );
As = X(:,1:ii);
[k,y] = OLS(As,z);
% Ca = inv(P'*P);
% kk = G\a;
% 
% k = kk;
% C = Ca;
% F = A*k;