function time = checkIfSync(varargin )
OBDdata = varargin{1};
if numel(varargin)==1
longitude = input('please type logitude');
latitude = input('please type latitude');
videoTime = input('please type video time');
else
    longitude = varargin{2};
    latitude =varargin{3};
    videoTime = varargin{4}; 
end
[X,Y] = ll2utm(latitude, longitude);
[x y] = ll2utm(OBDdata.GPS_lat, OBDdata.GPS_long);
distanceSq = (x-X).^2+(y-Y).^2;
[minDist index] = min(distanceSq);
time = OBDdata.time(index) - videoTime;
end