function [yhat] = sigm_fit_val(param,x)
% SIGM_FIT_VAL returns estimated Y for the sigmoidal function with given PARAM and of a given X vector.
% 
% The functions sigm_fit and sigm_fit_val are the equivalent of the builtin
% Matlab functions polyfit and polyval for sigmoid functions.
%
% sigm_fit is available on http://www.mathworks.com/matlabcentral/fileexchange/42641-sigm-fit
%
% Syntax:    [yhat] = sigm_fit_val(param,x)
%
% Example:
%       xdata=[0 ,50  ,100 ,150,200,250 ,300,350,400,450,500, 550,600, 650, 700,750, 800, 850, 900, 950,1000];
%       ydata=[-29,-205,-156,-50 ,-28,-103,249,120,86,178,740,1199,918,1096,1065,1074,1004,1193,1122,860,1045];
%       [param]=sigm_fit(xdata,ydata,[],[0 1000 500 0.01],0)
%       x = 0:20:1000;
%       [yhat] = sigm_fit_val(param,x);
%       plot(x,yhat)
%
% Doubts, bugs: rpavao@gmail.com

fsigm = @(param,xval) param(1)+(param(2)-param(1))./(1+10.^((param(3)-xval)*param(4)));
yhat = fsigm(param,x);
