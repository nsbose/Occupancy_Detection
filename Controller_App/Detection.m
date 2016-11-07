function Detection( varargin )
%DETECTION Summary of this function goes here
%   Based on the threshold data does basic detection
%white = evalin('base','white(:,2:end)');
diff_white = evalin('base','diff_white');
diff_red = evalin('base','diff_red');
diff_green = evalin('base','diff_green');
diff_blue = evalin('base','diff_blue');

diff_max_white = max(diff_white')';
diff_max_red = max(diff_red')';
diff_max_green = max(diff_green')';
diff_max_blue = max(diff_blue')';

assignin('base','diff_max_white',diff_max_white);
assignin('base','diff_max_red',diff_max_red);
assignin('base','diff_max_green', diff_max_green);
assignin('base', 'diff_max_blue', diff_max_blue);

% find peaks
%[peaks, locs] = findpeaks(diff_white(1,:));



end

