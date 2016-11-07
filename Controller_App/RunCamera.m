function RunCamera(varargin)
%RUNCAMERA Summary of this function goes here
%
%   Begins the recorder script and dumps the data in specified file

java_file = 'C:\Nelson\School\MS_Project\main_project\Recorder\recorder\recorder.jar ';
yml_file = 'C:\Nelson\School\MS_Project\main_project\Recorder\recorder\config.yml ';
output_location = 'C:\Nelson\School\MS_Project\Occupancy_Detection\Controller_App\Data';

cmdfile = ['java -jar ' java_file yml_file output_location ' CSV'];
system(cmdfile);

end
