function extraction_CSV( varargin )
%EXTRACTION_CSV Summary of this function goes here
%   Extracts RGB and Lux values from a given CSV file
    
    filename = varargin{1};
    fid = fopen(filename);
    output = textscan(fid,'%s%s%s%s%s%s%s%s%s', 'Delimiter',',');
    fclose(fid);
    
    % Extracted values and outputs them as doubles
    blue = output{1}(2:end,1);
    blue = [cellfun(@str2num,blue(1:end,1),'un',0).'];
    blue = cell2mat(blue(:));
    
    
    green = output{2}(2:end,1);
    green = [cellfun(@str2num,green(1:end,1),'un',0).'];
    green = cell2mat(green(:));
    
    red = output{5}(2:end,1);
    red = [cellfun(@str2num,red(1:end,1),'un',0).'];
    red = cell2mat(red(:));
    
    white = output{9}(2:end,1);
    white = [cellfun(@str2num,white(1:end,1),'un',0).'];
    white = cell2mat(white(:));
    
    time1 = output{7}(2:end,1);
    time1 = [cellfun(@str2num,time1(1:end,1),'un',0).'];
    time1 = cell2mat(time1(:));
    
    time2 = output{8}(2:end,1);
    time2 = [cellfun(@str2num,time2(1:end,1),'un',0).'];
    time2 = cell2mat(time2(:));
    
    sensorID = output{6}(2:end,1);
    sensorID = [cellfun(@str2num,sensorID(1:end,1),'un',0).'];
    sensorID = cell2mat(sensorID(:));

    sindex{1,1} = find(sensorID == 0);
    sindex{2,1} = find(sensorID == 1);
    sindex{3,1} = find(sensorID == 2);
    sindex{4,1} = find(sensorID == 3);
    sindex{5,1} = find(sensorID == 4);
    sindex{6,1} = find(sensorID == 5);
    sindex{7,1} = find(sensorID == 6);
    sindex{8,1} = find(sensorID == 7);
    sindex{9,1} = find(sensorID == 8);
    sindex{10,1} = find(sensorID == 9);
    sindex{11,1} = find(sensorID == 10);
    sindex{12,1} = find(sensorID == 11);
    
    % deletes any camera data prior to the initial sensor 0
    
    for i = 2:12
        if sindex{i,1}(1) < sindex{1,1}(1)
           sindex{i,1}(1) = []; % deletes the first array
        end
    end
    
    % deletes final camera data post final sensor 11 data
    for i = 1:11
        if sindex{i,1}(end) > sindex{12,1}(end)
            sindex{i,1}(1) = [];
        end
    end
    
    
    % outputs for study
    for i = 1:12
        sblue(i,1) = i-1;
        sblue(i,2:size(sindex{i,1},1)+1) = blue(sindex{i,1});
    end
    
    for i = 1:12
        sgreen(i,1) = i-1;
        sgreen(i,2:size(sindex{i,1},1)+1) = green(sindex{i,1});
    end
    
    for i = 1:12
        sred(i,1) = i-1;
        sred(i,2:size(sindex{i,1},1)+1) = red(sindex{i,1});
    end
    
    for i = 1:12
        swhite(i,1) = i-1;
        swhite(i,2:size(sindex{i,1},1)+1) = white(sindex{i,1});
        
    end
    for i = 1:12
        stime1(i,1) = i-1;
        stime1(i,2:size(sindex{i,1},1)+1) = time1(sindex{i,1});
    end
    
    for i = 1:12
        stime2(i,1) = i-1;
        stime2(i,2:size(sindex{i,1},1)+1) = time2(sindex{i,1});
    end

    assignin('base','blue',sblue);
    assignin('base','green',sgreen);
    assignin('base','red',sred);
    assignin('base','white',swhite);
    assignin('base','output',output);
    assignin('base','time1',stime1);
    assignin('base','time2',stime2);
    
    
    [row, col] = size(swhite(1,2:end));
    timelen = zeros(1,col); % creates blank array of total time
    count = 1; %sets initial to 1
    for i = 1:col
        timelen(i) = count;
        count = count+0.2; % increments by 0.2 to get total time length
    end
    
    assignin('base','timelen',timelen);
    
    stitle = 'Sensor ';

    figure('Name', 'Blue Sensors','Position', [100 30 750 700]); 
    for i = 1:12
        s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen,sblue(i,2:end));
        title(s); xlabel('time(secs)');
    end
    
    figure('Name', 'Red Sensors','Position', [100 30 750 700]); 
    for i = 1:12
        s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen,sred(i,2:end));
        title(s); xlabel('time(secs)');
    end
    
    figure('Name', 'Green Sensors','Position', [100 30 750 700]); 
    for i = 1:12
        s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen,sgreen(i,2:end));
        title(s); xlabel('time(secs)');
    end
    
    figure('Name', 'White Lux Sensors','Position', [100 30 750 700]);
    for i = 1:12
        s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen,swhite(i,2:end));
        title(s); xlabel('time(secs)');
    end
    
%     figure('Name', 'Time 1','Position', [130 30 750 700]);
%     for i = 1:12
%         s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen,stime1(i,2:end));
%         title(s); xlabel('time(secs)');
%     end
%     
%     figure('Name', 'Time 2','Position', [160 30 750 700]);
%     for i = 1:12
%         s = [stitle num2str(i)]; subplot(4,3,i); plot(timelen,stime2(i,2:end));
%         title(s); xlabel('time(secs)');
%     end
%     
end

