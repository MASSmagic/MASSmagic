function [ sites ] = parseXMLFile( XMLFile )
%This function takes a file input and outputs a struct (data structure)
%containing all of the target site information. In order to prompt the user
%to provide the correct target file, use the following piece of code
%(uncommented) in either the command window or the function calling this
%function. It is not necessary to display the user's selection, but you
%might want to include some error handling in case the user selects cancel.
%
%[filename, pathname] = uigetfile('*.xml', 'Select a file to load');
%if isequal (filename, 0)
%    disp('User selected Cancel')
%else
%    disp(['User selected ', fullfile(pathname, filename)])
%end
%XMLFile = fullfile(pathname, filename);

%Read XML file
XMLFile2=fullfile(pwd,'TargetSites.xml'); %HARDCODED
XMLDoc = xmlwrite(XMLFile2);
a=strsplit(XMLDoc,{'<wmc__TEOSite Category="Daily"','</wmc__TEOSite>'});
no_of_targets = (length(a)-1)/2;
sites(no_of_targets) = struct('site_no',[], 'passover_time',[], 'target_name',[], 'lat',[], 'long', [], 'notes', [], 'lenses', [], 'closest_approach', []);

%Store each site's data in a sites struct.
for i=1:no_of_targets
    b = char(a(2*i));
    
    %site_no
    sites(i).site_no=i;
    
    %target_name
    namearr = strsplit(b,'Nomenclature="');
    name = char(namearr(2));
    namearr2 = strsplit(name,'"');
    name = char(namearr2(1));
    sites(i).target_name=name;
    
    %passover_time
    notesarr = strsplit(b, {'Notes="','>'});
    notes = char(notesarr(2));
    timearr = strsplit(notes, ';');
    sites(i).passover_time=char(timearr(1));
    
    %lenses
    lenses = char(timearr(2));
    lensarr = strsplit(lenses, ': ');
    lenses = char(lensarr(2));
    sites(i).lenses=lenses;
    
    %notes
    notes2=strsplit(char(timearr(3)),'"');
    sites(i).notes=char(notes2(1));
    
    %lat and long and closest_approach
    if(length(timearr)>3)
        latlon = char(timearr(4));
        latarr = strsplit(latlon,'lat: ');
        lati = char(latarr(2));
        lonarr = strsplit(lati,{', lon:',' '});
        lati = char(lonarr(1));
        longi = char(lonarr(2));
        close = char(lonarr(4));
        close = close(1:end-1);
        sites(i).lat=lati;
        sites(i).long=longi;
        sites(i).closest_approach=close;
    end
end
end

