%%
% Masters Project - Occupancy Detection
% GUI based panel allowing user to see in real time the number of occupants
% Also displays in real-time the different enviornmental conditions 
% 
% Author: Neladri Bose
% Institution: Boston University
% Advisor: Prof. Thomas Little
% Initial Version: 10/12/2016
% Gathers data from ThingSpeak IoT service - https://thingspeak.com/
%%



function varargout = main_app_panel(varargin)
% MAIN_APP_PANEL MATLAB code for main_app_panel.fig
%      MAIN_APP_PANEL, by itself, creates a new MAIN_APP_PANEL or raises the existing
%      singleton*.
%
%      H = MAIN_APP_PANEL returns the handle to a new MAIN_APP_PANEL or the handle to
%      the existing singleton*.
%
%      MAIN_APP_PANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_APP_PANEL.M with the given input arguments.
%
%      MAIN_APP_PANEL('Property','Value',...) creates a new MAIN_APP_PANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_app_panel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_app_panel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_app_panel

% Last Modified by GUIDE v2.5 21-Oct-2016 15:18:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_app_panel_OpeningFcn, ...
                   'gui_OutputFcn',  @main_app_panel_OutputFcn, ...
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


% --- Executes just before main_app_panel is made visible.
function main_app_panel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_app_panel (see VARARGIN)

% Choose default command line output for main_app_panel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes main_app_panel wait for user response (see UIRESUME)
% uiwait(handles.fig_main_app);


% --- Outputs from this function are returned to the command line.
function varargout = main_app_panel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function tbox_enter_channel_Callback(hObject, eventdata, handles)
% hObject    handle to tbox_enter_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tbox_enter_channel as text
%        str2double(get(hObject,'String')) returns contents of tbox_enter_channel as a double
handles.channel_num = str2num(get(hObject,'string'));

% --- Executes during object creation, after setting all properties.
function tbox_enter_channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tbox_enter_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_enter_channel.
function btn_enter_channel_Callback(hObject, eventdata, handles)
% hObject    handle to btn_enter_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
channel_num = get(handles.tbox_enter_channel, 'string');
api_value = get(handles.tbox_enter_api, 'string');


handles.channel_ID = str2num(channel_num);
handles.api_id = api_value;
channel_num = str2num(channel_num);
assignin('base','channel_num',channel_num);
assignin('base','api_value',api_value);
thingspeak_call(channel_num, api_value, handles);





% --- Executes on button press in btn_Clear.
function btn_Clear_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in btn_save.
function btn_save_Callback(hObject, eventdata, handles)
% hObject    handle to btn_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function tbox_enter_api_Callback(hObject, eventdata, handles)
% hObject    handle to tbox_enter_api (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tbox_enter_api as text
%        str2double(get(hObject,'String')) returns contents of tbox_enter_api as a double


% --- Executes during object creation, after setting all properties.
function tbox_enter_api_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tbox_enter_api (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Calls call_thingspeak function to constantly connect and get
% thingspeak data from online server and update window
function thingspeak_call(channel_num, api_value, handles)

i = 1;
total_data = [];

while (i <= 5)
    photon_data = call_thingspeak(channel_num, api_value);
    set(handles.txt_temp1_input,'string',num2str(photon_data(1)));
    set(handles.txt_pressure_input, 'string', num2str(photon_data(2)));
    set(handles.txt_lux_input, 'string', num2str(photon_data(4)));
    set(handles.txt_humidity_input, 'string', num2str(photon_data(5)));
    set(handles.txt_temp2_input, 'string', num2str(photon_data(6)));
    set(handles.txt_occupant_input, 'string', num2str(i));
    
    total_data(i,1:6) = photon_data;
    assignin('base', 'photon_data', total_data);
    pause(5);
    
    i = i+1;
    
    

end
    





%assignin('base', 'photon_data', total_data);