function ContourPlot
%CONTOUR Summary of this function goes here
%   Detailed explanation goes here

% create the time series

diff_white_f = evalin('base','diff_white_f');
diff_red_f = evalin('base', 'diff_red_f');
diff_green_f = evalin('base', 'diff_green_f');
diff_blue_f = evalin('base','diff_blue_f');
timelen = evalin('base','timelen');


a = max(max(diff_white_f'));
y = linspace(0,a,length(diff_white_f));
z = y;
[X,Y] = meshgrid(timelen,y);
%b = diff_white_f(1,:);
b = diff_white_f(:,1:2);

ts_fwhite = timeseries(diff_white_f(1,:)',timelen,'Name','Absolute White');
% ts_fred = timeseries(diff_red_f',timelen,'Name','Absolute Red');
% ts_fgreen = timeseries(diff_green_f',timelen,'Name','Absolute Green');
% ts_fblue = timeseries(diff_blue_f',timelen,'Name','Absolute Blue');
figure
surf(diff_white_f);
% contour(X,Y,b)

end

