addpath('func')

%% define fixed regressor 
A = [ones(size(x1))'];

%% define candidate regressor
X = [x1(:),...
     x2(:),...
     x1(:).^2,...
     x2(:).^2,...
     x1(:).*x2(:),...
     x1(:).*x2(:).^2,...
     x1(:).^2.*x2(:)];

%% define output
z = y(:);

%% 
stop_critera = 'PSE';
plot_report = true;

[k_final,A_final,Log] = stepwise_model_structure(A,X,z,stop_critera,plot_report);
