function plotTarget()
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
sites = parseXMLFile(strcat(pwd,'\TargetSites.xml'));
for i = 1:numel(sites)
    lon = str2double(sites(i).long);
    lat = str2double(sites(i).lat);
    plot(lon,lat,'xm','MarkerSize',8,'LineWidth',2)
end

end

