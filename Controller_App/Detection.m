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

final_tally(1) = 0;
for j = 1:12
    totalcount = 0;
    %j = 3; % specifies which sensor

    init_max_white = max(hold_peaks_white{j,1});
    init_max_white_ind = find(hold_peaks_white{j,1} == init_max_white);
    
    % init_max_white = max(diff_max_white(j,1));
    % int_max_white_ind = find(diff_max_white(j,1) == init_max_white);
    
    % deletes surrounding max peaks so that a separate peak can be detected
    hold_peaks_white{j,1}(init_max_white_ind-2:init_max_white_ind+2) = 0; 
    
     
    count = 1;
    max_store = [];
    max_store(count) = init_max_white;
    a = 0;
    % counts the number of peaks and stores the values
    while a == 0 % loops through calculate the max
        %count = count + 1; % update the counter
        temp_max = max(hold_peaks_white{j,1});
        % temp_max = max();
        max_white_ind = find(hold_peaks_white{j,1} == temp_max); % dynamically update the maximum peak
        if (((length(hold_peaks_white{j,1})-1) > max_white_ind) & max_white_ind > 2)
            hold_peaks_white{j,1}(max_white_ind-2:max_white_ind+2) = 0; 
            
            diff_max_white = (abs(init_max_white - temp_max) /  init_max_white);
            diff_max_white = diff_max_white * 100;
            
            if diff_max_white < 37.0
                count = count + 1; % update the counter
                max_store(count) = temp_max;

            end
        else
            a = 1;
        end
        %init_max_white = temp_max;

    end
        
    assignin('base','max_store',max_store);
    assignin('base', 'peakcount', count);
    if mod(count,2) == 0
        totalcount = count / 2;
         disp(totalcount);
    else
        if count > 1
            %count = count - 1;
            totalcount = (count + 1) / 2;
            %disp(totalcount);
        else
            %disp(1);
        end
    end
    final_tally(j,2) = totalcount;
    final_tally(j,1) = j;
end

assignin('base','final_tally',final_tally);
assignin('base','Total_Occupants', mode(final_tally));
end

