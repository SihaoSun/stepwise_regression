function [k,A,Log] = stepwise_model_structure(A,X,z,stop_criteria, plot_report)
%% Stepwise regression
%  Stepwise model structure selection.
%  The F test is used to judge which candidate regressor should be added to the
%  model. At the same time, in each step the included regressor might be  
%  eliminated because of low correlation with the output.
%  
%  reference: 
%   [1]K.Vladislav,EA.Morelli. "Aircraft system identification: theory and 
%      practice".2006. P141-P151
%  input:
%  A : fixed regressor matrix, always includes constant element and user predefined fixed
%      regressors. 
%  X : candidate regressors. 
%  z : measurement. 
%  stop_criteria: 'PSE', 'R2', 'F0'
%  plot_report: bool value to determine if plot the estimation result.

%  output:
%  k : parameters estimated corresponding to each regressor
%  A : final regressor matrix
%  Log : log for stepwise selection. 2nd column records the index of
%        selected regressor from candidate pool. 3rd column records the 
%        index of eliminated regressor from existing regressors.
%        4-7th columns respectively record the PSE, R2, F0 and RMS of 
%        current model.
%
%  Sihao Sun  21-Apr-2017
%  S.Sun-4@tudelft.nl

Xout = [];
Log = [];
% PSEtol = 1e-3;

step = 1;

[N,p0] = size(A);
p = p0;
[~,y] = OLS(A,z);
PSE = find_PSE(y,z,p);
R2 = find_R2(y,z);
F0 = (N-p)/(p-1)*R2/(1-R2);
PSE_last = PSE;
R2_last = R2;
F0_last = F0;
PSEtol = 0.001*PSE;
A_last = A;

display(PSE);
display(R2);

if plot_report
   figure
   plot(z); hold on;
end
while 1    
    Log = [Log;zeros(1,7)];
    Log(step,1) = step;
    
    r = z - y;
    
    %selection process
    V = zeros(size(X)); %new candidate regressor
    for jj = 1:size(X,2)
        x = X(:,jj);
        ka = OLS(A,x);
        V(:,jj) = x-A*ka;
    end
    
    cor = abs(corr(V,r));
    [~,j] = max(cor);    
    [~,in] = forward_selection(X,A,z,5,j); 
    if in == true
        Xin = X(:,j);
        A = [A,Xin];
        X(:,j) = [];
    else
       Log(end,:) = [];
       fprintf('No qualified candidates\n');
       break; 
    end
    
    if isequal(Xin,Xout)
        A = A(:,1:end-1);
        [k,y] = OLS(A,z);
        fprintf('Xin equals Xout\n');
        break;
    end
    
    %kick out process
    [i,~,out] = backward_elimination(A,z,4);
    if out == true
        Xout = A(:,i);
        A(:,i) = [];
    else
        Xout = [];
    end

    %least square
    [k,y] = OLS(A,z);
    
    if plot_report
        plot(y);
    end

    fprintf('------------Step = %d -------------\n',step);
    fprintf('\nselected = %d\n',j);
%     display(k);
    Log(step,2) = j;
    if out == true 
        fprintf('Kick out --> %d\n',i);
        Log(step,3) = i;
    end
    
    
    %stopping criteria
    p = size(A,2);
    PSE = find_PSE(y,z,p);
    R2 = find_R2(y,z);
    rms_residual = rms(y-z)/(max(z)-min(z));
    F0 = (N-p)/(p-1)*R2/(1-R2);
    
    Log(step,4) = PSE;
    Log(step,5) = R2;
    Log(step,6) = F0;
    Log(step,7) = rms_residual;
    
    display(PSE);
    display(R2);
    
    switch stop_criteria
        case 'PSE'
            if PSE >= PSE_last*0.99
                A = A_last;
                [k,y] = OLS(A,z);
                fprintf('PSE increases\n');
                break;
            end    
            if PSE<PSEtol
                fprintf('PSE is enough small\n');
                break;
            end    
        case 'R2'
            if R2 <= R2_last*1.005
                fprintf('R2 has no significant growth');
                break;
            end
        case 'F0'
            if F0 <= F0_last
                fprintf('F0 reaches the maximum value');
                break;
            end
        otherwise
            if step >= 10
                fprintf('No stopping criterion assigned, too many steps!');
            end
    end
     
    A_last = A;
    PSE_last = PSE;  
    R2_last = R2;
    F0_last = F0;
    if isempty(X)
        fprintf('No candidate regressors left / over steps\n');
        break;
    end
    
    step = step + 1;
end

end