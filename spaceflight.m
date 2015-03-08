function varargout = spaceflight(varargin)
% SPACEFLIGHT MATLAB code for spaceflight.fig
%      SPACEFLIGHT, by itself, creates a new SPACEFLIGHT or raises the existing
%      singleton*.
%
%      H = SPACEFLIGHT returns the handle to a new SPACEFLIGHT or the handle to
%      the existing singleton*.
%
%      SPACEFLIGHT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPACEFLIGHT.M with the given input arguments.
%
%      SPACEFLIGHT('Property','Value',...) creates a new SPACEFLIGHT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before spaceflight_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to spaceflight_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help spaceflight

% Last Modified by GUIDE v2.5 08-Mar-2015 12:24:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spaceflight_OpeningFcn, ...
                   'gui_OutputFcn',  @spaceflight_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before spaceflight is made visible.
function spaceflight_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spaceflight (see VARARGIN)

%% Music player code
dirlist=dir('Music');
handles.playlist=dirlist(3:length(dirlist));
handles.count=1;
handles.pausebool=1;
[y, Fs]=audioread(strcat('Music\',handles.playlist(handles.count).name));
handles.player=audioplayer(y,Fs);

%% Timer
[lat,lon] = getISScoord();

%Big Map
set(handles.BigMap,'XLim',[lon-45,lon+45],'YLim',[lat-21,lat+21])
plot(handles.BigMap,plot_google_map)
plot(handles.BigMap,lon,lat,'or','MarkerSize',5,'LineWidth',2)

%Little Map
ax = handles.LilMap;
plotOrbitalPath(ax)
%plot(handles.LilMap,plotOrbitalPath)

%% Logo
axes(handles.logo);
imshow('massmagiclogo.png');

%%Show first Target and fill fields
handles.sites=parseXMLFile('TargetSites.xml');
handles.sitecounter=1;
set(handles.destinationtext,'String',handles.sites(handles.sitecounter).target_name);
set(handles.notestext,'String',handles.sites(handles.sitecounter).notes);
set(handles.lenstext,'String',handles.sites(handles.sitecounter).lenses);
targetstr=strcat(num2str(handles.sitecounter),'/',num2str(length(handles.sites)));
set(handles.targetlist,'String',targetstr);

%%Timer Functionality and run timeTilTarget
handles.countdowntimer=timeTilTarget(lat,lon);
set(handles.countdown,'String',handles.countdowntimer);

%% Other
% Choose default command line output for spaceflight
handles.output = hObject;

% timer to update
handles.timer = timer(...
    'ExecutionMode', 'fixedRate', ...   % Run timer repeatedly
    'Period', 3, ...                % Initial period is 3 sec.
    'TimerFcn', {@update_display,hObject}); % Specify callback

start(handles.timer);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes spaceflight wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spaceflight_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PlayButton.
function PlayButton_Callback(hObject, eventdata, handles)
% hObject    handle to PlayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.pausebool==1
    handles.pausebool=0;
    set(handles.songtitle,'String',handles.playlist(handles.count).name(1:length(handles.playlist(handles.count).name)-4));
    handles.player.resume;
else
    if handles.count>length(handles.playlist)
        handles.count=1;
    end
    [y Fs]=audioread(strcat('Music\',handles.playlist(handles.count).name));
    handles.player=audioplayer(y,Fs);
    set(handles.songtitle,'String',handles.playlist(handles.count).name(1:length(handles.playlist(handles.count).name)-4));
    play(handles.player);
    handles.count=handles.count+1;
end
guidata(hObject,handles);


% --- Executes on button press in PauseButton.
function PauseButton_Callback(hObject, eventdata, handles)
% hObject    handle to PauseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.pausebool=1;
handles.player.pause;
guidata(hObject,handles)

% --- Executes on button press in SkipButton.
function SkipButton_Callback(hObject, eventdata, handles)
% hObject    handle to SkipButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.player.isplaying
   handles.pausebool=1;
   handles.player.pause;
end
handles.count=handles.count+1;
if handles.count>length(handles.playlist)
    handles.count=1;
end
[y Fs]=audioread(strcat('Music\',handles.playlist(handles.count).name));
handles.player=audioplayer(y,Fs);
set(handles.songtitle,'String',handles.playlist(handles.count).name(1:length(handles.playlist(handles.count).name)-4));
play(handles.player);
guidata(hObject,handles)

% --- Executes on button press in scrolltarget.
function scrolltarget_Callback(hObject, eventdata, handles)
% hObject    handle to scrolltarget (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.sitecounter==length(handles.sites)
    handles.sitecounter=1;
else
    handles.sitecounter=handles.sitecounter+1;
end
set(handles.destinationtext,'String',handles.sites(handles.sitecounter).target_name);
set(handles.notestext,'String',handles.sites(handles.sitecounter).notes);
set(handles.lenstext,'String',handles.sites(handles.sitecounter).lenses);
targetstr=strcat(num2str(handles.sitecounter),'/',num2str(length(handles.sites)));
set(handles.targetlist,'String',targetstr);
guidata(hObject,handles)

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over countdown.
function countdown_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to countdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[lat,lon] = getISScoord();
handles.countdowntimer=timeTilTarget(lat,lon);
set(handles.countdown,'String',handles.countdowntimer);

% --- Executes during object creation, after setting all properties.
function LilMap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
%plotOrbitalPath()
% Hint: place code in OpeningFcn to populate LittleMap


% --- Executes during object creation, after setting all properties.
function BigMap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BigMap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate BigMap


%% User functions
%this function updates display (is called every 3 seconds) and updates
%countdown timer
function update_display(hObject,eventdata,hfigure)

[y,x] = getISScoord();
handles = guidata(hfigure);
%handles.countdowntimer=handles.countdowntimer-3;
%set(handles.countdown,'String',handles.countdowntimer);
set(handles.BigMap.Children(2),'XData',x,'YData',y,'Marker','o','MarkerSize',5,'LineWidth',2);
%guidata(hObject, handles);
