function [ time ] = timeTilTarget(lat, lon)
    %This function calculates the time til destination of inputed
    %lattitude and longitude based on an API call

    %get time of destination in UNIX time stamp
    urlbuild=strcat('http://api.open-notify.org/iss-pass.json?lat=',num2str(lat),'&lon=',num2str(lon));
    result=urlread(urlbuild);
    rise1 = strsplit(result,'"risetime":');
    rise2 = strsplit(char(rise1(2)),'}');
    risetime = str2double(rise2(1));
    %convert unix time stamp to GMT. THIS CODE IS NOT USED BUT MIGHT BE IN
    %FUTURE, as we can just deal in unix time stamps
    
    %urlbuild2=strcat('http://www.convert-unix-time.com/api?timestamp=',num2str(risetime));
    %result2=urlread(urlbuild2);
    %time1=strsplit(result2,'"localDate":"');
    %time2=strsplit(char(time1(2)),',');
    %time3=time2(1);
    %time3=time3{:};
    %time4=time3(end-11:end-1);
    %date=time3(1:end-13);
    %pm=time4(end-1:end);
    %if PM, change to military time
    %if strcmp(pm,'PM')
    %    charhour=time4(1:2);
    %    charhour=str2double(charhour);
    %    charhour=charhour+12;
    %    charhour=num2str(charhour);
    %    time4(1)=charhour(1);
    %    time4(2)=charhour(2);
    %end
    %militarytime=time4(1:end-3);
    
    %calculate time til destination
    currenttime=datestr(datevec(datenum(clock)));
    dnOffset=datenum('01-Jan-1970');
    arrivaltime=datestr(risetime/(24*60*60)+dnOffset);
    time=etime(datevec(arrivaltime),datevec(currenttime));
end
