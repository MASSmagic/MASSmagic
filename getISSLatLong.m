function [ latitude, longitude ] = getISSLatLong()
%This function outputs the latitude and longitude of the current ISS
%position, if you were to project its location onto the surface of
%the earth. The method "urlread" sends a request to the Open Notify API,
%and recieves a JSON string response. The string is parsed so that only the
%desired information remains. Try unsuppressing (removing the semi-colons)
%after each line to see what is happening here. 
%Use "format long" in the command window to obtain more decimal precision. 

latlong=urlread('http://api.open-notify.org/iss-now.json');
latarr = strsplit(latlong,'"latitude":');
latarr2 = strsplit(char(latarr(2)),'}');
latitude = str2double(latarr2(1));

longarr = strsplit(latlong,{'"longitude":',','});
longitude = str2double(longarr(3));

end

