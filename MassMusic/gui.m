function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 21-Feb-2015 16:15:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

%start musicplayer code

dirlist=dir('Music');
handles.playlist=dirlist(3:length(dirlist));
handles.count=1;
handles.pausebool=1;
[y Fs]=audioread(strcat('Music\',handles.playlist(handles.count).name));
handles.player=audioplayer(y,Fs);
%end musicplayer code

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
    
% --- Executes on button press in playbutton.
function playbutton_Callback(hObject, eventdata, handles)
% hObject    handle to playbutton (see GCBO)
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

% --- Executes on button press in pausebutton.
function pausebutton_Callback(hObject, eventdata, handles)
% hObject    handle to pausebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.pausebool=1;
handles.player.pause;
guidata(hObject,handles)

% --- Executes on button press in skipbutton.
function skipbutton_Callback(hObject, eventdata, handles)
% hObject    handle to skipbutton (see GCBO)
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
