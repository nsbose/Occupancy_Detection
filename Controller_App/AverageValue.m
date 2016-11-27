function AverageValue 
%AVERAGEVALUE Summary of this function goes here
%   Takes the average value of the first 20 seconds of the samples
%   Moving average filter on the main data

% Performs the moving average

white = evalin('base','white(:,2:end)');
red = evalin('base','red(:,2:end)');
green = evalin('base','green(:,2:end)');
blue = evalin('base','blue(:,2:end)');
timelen = evalin('base','timelen(1,:)');

% only averages for the first 15 seconds
avg_white = mean(white(:,1:75),2);
avg_red = mean(red(:,1:75),2);
avg_green = mean(green(:,1:75),2);
avg_blue = mean(blue(:,1:75),2);

% [row, col] = size(white);
% timelen = zeros(1,col); % creates blank array of total time
% count = 1; %sets initial to 1
% for i = 1:col
%     timelen(i) = count;
%     count = count+0.2; % increments by 0.2 to get total time length
% end
diff_white = abs(white - avg_white);
diff_red = abs(red - avg_red);
diff_green = abs(green - avg_green);
diff_blue = abs(blue - avg_blue);



stitle = 'Sensor ';
% 
%     figure('Name', 'Abs Blue Sensors Difference','Position', [100 30 750 700]); 
%     for i = 1:12
%         s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen, diff_blue(i,:));
%         title(s); xlabel('time(secs)');
%     end
%     
%     figure('Name', 'Abs Red Sensors Difference','Position', [100 30 750 700]); 
%     for i = 1:12
%         s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen, diff_red(i,:));
%         title(s); xlabel('time(secs)');
%     end
%     
%     figure('Name', 'Abs Green Sensors Difference','Position', [100 30 750 700]); 
%     for i = 1:12
%         s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen, diff_green(i,:));
%         title(s); xlabel('time(secs)');
%     end
%     
%     figure('Name', 'Abs White Lux Sensors Difference','Position', [100 30 750 700]);
%     for i = 1:12
%         s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen, diff_white(i,:));
%         title(s); xlabel('time(secs)');
%     end
% 

assignin('base', 'avg_white', avg_white);
assignin('base', 'avg_red', avg_red);
assignin('base', 'avg_green', avg_green);
assignin('base', 'avg_blue', avg_blue);
assignin('base', 'timelen', timelen);
assignin('base', 'diff_white', diff_white);
assignin('base', 'diff_red', diff_red);
assignin('base', 'diff_green', diff_green);
assignin('base', 'diff_blue', diff_blue);


% filtering to smooth data
windowSize = 5;
b = (1/windowSize) * ones(1,windowSize);
a = 1;

diff_white_f = filter(b,a,diff_white);
diff_red_f = filter(b,a,diff_red);
diff_green_f = filter(b,a,diff_green);
diff_blue_f = filter(b,a,diff_blue);

assignin('base', 'diff_white_f', diff_white_f);
assignin('base', 'diff_red_f', diff_red_f);
assignin('base', 'diff_green_f', diff_green_f);
assignin('base', 'diff_blue_f', diff_blue_f);

    figure('Name', 'Filtered Abs Blue Sensors Difference','Position', [100 30 750 700]); 
    for i = 1:12
        s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen, diff_blue_f(i,:));
        title(s); xlabel('time(secs)');
    end
    
    figure('Name', 'Filtered Abs Red Sensors Difference','Position', [100 30 750 700]); 
    for i = 1:12
        s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen, diff_red_f(i,:));
        title(s); xlabel('time(secs)');
    end
    
    figure('Name', 'Filtered Abs Green Sensors Difference','Position', [100 30 750 700]); 
    for i = 1:12
        s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen, diff_green_f(i,:));
        title(s); xlabel('time(secs)');
    end
    
    figure('Name', 'Filtered Abs White Lux Sensors Difference','Position', [100 30 750 700]);
    for i = 1:12
        s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen, diff_white_f(i,:));
        title(s); xlabel('time(secs)');
    end

end


