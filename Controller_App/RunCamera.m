function RunCamera(varargin)
%RUNCAMERA Summary of this function goes here
%   Detailed explanation goes here

java_file = 'C:\Nelson\School\MS_Project\main_project\Recorder\recorder\recorder.jar ';
yml_file = 'C:\Nelson\School\MS_Project\main_project\Recorder\recorder\config.yml ';
output_location = 'C:\Nelson\GitHub\ms_project\Controller_App\Data\Data_Dump';

cmdfile = ['java -jar ' java_file yml_file output_location ' CSV'];
system(cmdfile);

end
