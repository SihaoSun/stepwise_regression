function R2 = find_R2(y,z) 
% Compute R2 to evaluate model accuracy
% y : model output, 1 demension vector
% z : measurement, 1 demension vector
% Sihao Sun 21-12-2016

R2 = 1-sum((z-y).^2)/sum((z-mean(z)).^2);
end
