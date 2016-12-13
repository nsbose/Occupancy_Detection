function Detection( varargin )
%DETECTION Summary of this function goes here
%   Based on the threshold data does basic detection
%   Calculates the maximum amount of peaks

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

final_tally(1) = 0; % clears the value

x = 1; % smoothing of the edges
thres_percentage = 35.0;
for j = 1:12 % from sensors 1 to 12
    
    totalcount = 0;
    init_max_white = 0;
    init_max_white = max(hold_peaks_white{j,1});
    init_max_white_ind = find(hold_peaks_white{j,1} == init_max_white);
    
    % deletes surrounding max peaks so that a separate peak can be detected
    hold_peaks_white{j,1}(init_max_white_ind-x:init_max_white_ind+x) = 0; 
     
    count = 1;
    b = 0;
    max_store = []; % clears for every new sensor
    if isempty(hold_peaks_white{j,1})
        init_max_white = 0;
        b = 1;
    end
    max_store(count) = init_max_white;
    a = 0;
    % counts the number of peaks and stores the values
    while a == 0 % loops through calculate the max
        
        temp_max = max(hold_peaks_white{j,1});
        max_white_ind = find(hold_peaks_white{j,1} == temp_max); % dynamically update the maximum peak
        if (((length(hold_peaks_white{j,1})- 1) >= max_white_ind) & max_white_ind > x)
            hold_peaks_white{j,1}(max_white_ind-x:max_white_ind+x) = 0; 
            
            diff_max_white = (abs(init_max_white - temp_max) /  init_max_white) * 100;
            
            if diff_max_white < thres_percentage % threshold of anything less than 35%
                count = count + 1; % update the counter
                max_store(count) = temp_max;
            end
        else
            a = 1; % breaks the loop
        end

    end
    
    totalcount = count/2; % division is done, every 2 peaks = 1 count

    if b == 1
        totalcount = 0;
    end
    
    final_tally(j,1) = j;
    final_tally(j,2) = totalcount;
    
end

%average = (mean(final_tally(:,2)));

[ii,~,val] = find(final_tally(:,2)); % ignores if there are zeros
%average1 = [accumarray(ii,val,[],@mean)];

average = mean(val);
mode_val = mode(val);
%mode_val = (mode(final_tally(:,2)));


occupants = 0; % compares between mean and mode and takes
if average >= mode_val
    occupants = round(average); % higher mean takes presidence over mode
else
    occupants = round(mode_val);
end

assignin('base','max_store',max_store);
assignin('base', 'peakcount', count);
assignin('base','final_tally',final_tally);
assignin('base','Total_Occupants', occupants);


disp('White Lux Sensors');
disp(num2str(final_tally));
disp(['Rounded Average: ' num2str(average)]);
disp(['Mode: ' num2str(mode_val)]);
disp(['Occupants: ' num2str(occupants)]);
end

