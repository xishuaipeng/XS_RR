function [OBD_table, tripID,Path]= TRI_GPS_extract_oneTrip(varargin)
%---------------------------------------------------------------------------
%TRI_GPS_extract_oneTrip   Main program for extracting GPS data from raw 
% data
%
%   Usage:
%       TRI_GPS_extract_oneTrip (run in command window)
%       select the raw dat(RUN.csv file) and select path to save OBD data
%   @input:
%       None
%   @output:
%       None
%---------------------------------------------------------------------------
%
%---------------------------------------------------------------------------
% @author: Ruirui Liu
% @date:   Jul.20.2017
% @copyright: Intelligent System Laboratory University of Michigan-Dearborn
%---------------------------------------------------------------------------
if numel(varargin)==0
    [fileName filePath] = uigetfile('D:\Ruirui\courses\ECE537\project\*.csv');
else
   [filePath,fileName,ext] = fileparts(varargin{1});
   filePath = [filePath '\'];
   fileName = [fileName ext];
end
fid=fopen(fullfile(filePath,'data_OBD.log'),'w+');

if fid==-1
    error('cannot log data synchronization process');
end
fprintf(fid,'beginning time: %s\n',datestr(datetime));
obd_file=getOBDfile(filePath,fileName);
OBD = extractOBDinfo(obd_file,fid);
Params = {'time', 'speed', 'GPS_long', ...
    'GPS_lat', 'GPS_heading', ...
    'long_accel', 'lat_accel','vector_accel',...
    'vert_accel','distance', 'position_X', ...
    'position_Y','GPS_altitude'};
OBD_table = table(OBD.data(:,1), OBD.data(:,2), OBD.data(:,3), ...
    OBD.data(:,4), OBD.data(:,5), OBD.data(:,6), OBD.data(:,7), ...
    OBD.data(:,8), OBD.data(:,9), OBD.data(:,10), OBD.data(:,11), ...
    OBD.data(:,12), OBD.data(:,13), 'VariableNames',Params);
outputPath = strrep(filePath, 'raw_data', 'processed_data');
mkdir_if_not_exist(outputPath);
filePath = strrep(filePath, '/', '\');
split = strsplit(filePath,'\');
tripID = char(split(end-1));
outputName = strcat(tripID, '_OBD');
Path = char(strcat(outputPath, outputName, '.mat'));
save(Path,'OBD_table');
fclose(fid);
end % EOF
%