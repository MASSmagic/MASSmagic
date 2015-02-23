function [lat,lon] = getISScoord()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
latlong=urlread('https://api.wheretheiss.at/v1/satellites/25544');
latarr = strsplit(latlong,'"latitude":');
latarr2 = strsplit(char(latarr(2)),',');
lat = str2double(latarr2(1));

longarr = strsplit(latlong,'"longitude":');
longarr2 = strsplit(char(longarr(2)),',');
lon = str2double(longarr2(1));

end

