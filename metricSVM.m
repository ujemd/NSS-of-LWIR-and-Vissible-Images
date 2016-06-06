function res = metricSVM(fused,valY)
% Dependencies:
% - To compute steerable pyramid coefficients: matlabPyrTools.
%   Available: http://www.cns.nyu.edu/lcv/software.php
% - To predict using SVR: libsvm.
%   Available: https://www.csie.ntu.edu.tw/~cjlin/libsvm/
%
% Input:
% fused = fused image whose quality needs to be computed
% valY  = validation value for quality (optional)
%
% Output:
% res   = quality of input fused image. Higher values indicate worse
% quality.

% get default group of all NSS features
group = 'f+pp+pd+sp';
if nargin<2
    valY = 0;
end
% compute image features
features = [];
scalenum = 3;
for itr_scale = 1:scalenum
    % uses positive pd signs
    feat = computeGoodallFeatures(fused,group);
    features = [features; feat];
    fused = imresize(fused,0.5);
end

val.X = features';
val.Y = valY;

% load Y data (dmos)
load 'dmos.mat'
trn_data.Y = dmos';
% load X data (features)
load 'trainX.mat'
trn_data.X = X;

% rescale data before prediction
[~, val, ~] = scaleSVM(trn_data, val, trn_data, 0, 1);

% load SVR model
load SVMmodel.mat

% predict
[Q_SVM, ~, ~] = svmpredict(val.Y, val.X, model);

% logistic function
modelfun = @(b,x)(b(2)+(b(1)-b(2))./(1+exp(-(x-b(3))/abs(b(4)))));
% load logistic function parameters
load logistic-function-param.mat
% predict
% [y_hat, ~] = nlpredci(modelfun,Q_SVM,beta,R,'Jacobian',J);
res = feval(modelfun,beta_logistic,Q_SVM);