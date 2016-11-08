function Detection( varargin )
%DETECTION Summary of this function goes here
%   Based on the threshold data does basic detection

% uses data from the filtered sets
diff_white = evalin('base','diff_white_f');
diff_red = evalin('base','diff_red_f');
diff_green = evalin('base','diff_green_f');
diff_blue = evalin('base','diff_blue_f');

diff_max_white = max(diff_white')';
diff_max_red = max(diff_red')';
diff_max_green = max(diff_green')';
diff_max_blue = max(diff_blue')';

assignin('base','diff_max_white',diff_max_white);
assignin('base','diff_max_red',diff_max_red);
assignin('base','diff_max_green', diff_max_green);
assignin('base', 'diff_max_blue', diff_max_blue);

% find peaks
for i = 1:12
    [peaks, locs] = findpeaks(diff_white(i,:));
    hold_peaks_white{i,1} = peaks;
end

for i = 1:12
    [peaks, locs] = findpeaks(diff_red(i,:));
    hold_peaks_red{i,1} = peaks;
end

for i = 1:12
    [peaks, locs] = findpeaks(diff_green(i,:));
    hold_peaks_green{i,1} = peaks;
end

for i = 1:12
    [peaks, locs] = findpeaks(diff_blue(i,:));
    hold_peaks_blue{i,1} = peaks;
end

% 
assignin('base','hold_peaks_white',hold_peaks_white);
assignin('base','hold_peaks_red',hold_peaks_red);
assignin('base','hold_peaks_green',hold_peaks_green);
assignin('base','hold_peaks_blue',hold_peaks_blue);



end

