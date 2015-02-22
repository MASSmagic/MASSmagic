function secs = calcSecondsUntil( time_string )
%This function is meant to be used in conjunction with the parseXMLFile
%function. It takes the time_string stored in the sites struct and
%calculates the difference between that time and the current time. The
%current time is first changed to GMT. You may wish to modify this function
%to take in other types of inputs and consider other timezones. 

timedifference = 5; %number of hours between GMT and EST
current_date_time = clock;
current_date_time_in_gmt = addtodate(datenum(current_date_time),timedifference,'hour');

current_date_time_in_gmt_vector = datevec(current_date_time_in_gmt);
current_date = datestr(current_date_time_in_gmt_vector,'dd-mmm-yyyy');

passover_time = time_string(5:end);
passover_date_time_str = [current_date ' ' passover_time];
passover_date_time_vector = datevec(passover_date_time_str, 'dd-mmm-yyyy HH:MM:SS');
seconds_until_passover = etime(passover_date_time_vector, current_date_time_in_gmt_vector);

%If the passover time has already passed, assume the passover time is for the
%next day. You may definitely wish to change this assumption in your
%code.
if seconds_until_passover < 0
    passover_date_time_num = addtodate(datenum(passover_date_time_vector), 1, 'day');
    passover_date_time_vector = datevec(passover_date_time_num);
    seconds_until_passover = etime(passover_date_time_vector, current_date_time_in_gmt_vector);
end

secs = seconds_until_passover;