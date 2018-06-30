function varargout = Calibrate(varargin)
% CALIBRATE MATLAB code for Calibrate.fig
%      CALIBRATE, by itself, creates a new CALIBRATE or raises the existing
%      singleton*.
%
%      H = CALIBRATE returns the handle to a new CALIBRATE or the handle to
%      the existing singleton*.
%
%      CALIBRATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALIBRATE.M with the given input arguments.
%
%      CALIBRATE('Property','Value',...) creates a new CALIBRATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Calibrate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Calibrate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Calibrate

% Last Modified by GUIDE v2.5 29-Jun-2018 14:02:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Calibrate_OpeningFcn, ...
                   'gui_OutputFcn',  @Calibrate_OutputFcn, ...
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


% --- Executes just before Calibrate is made visible.
function Calibrate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Calibrate (see VARARGIN)

% Choose default command line output for Calibrate
handles.output = hObject;

% Update handles structure
set(gcf,'userdata',handles);
guidata(hObject, handles);

% UIWAIT makes Calibrate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Calibrate_OutputFcn(hObject, eventdata, handles) 
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
global addr
addrstr = dec2hex(addr);
set(handles.edit1,  'string', num2str(addr));

global calInfoFile
calInfoFile = ['addr', num2str(addr), '_', date, '.mat'];
global calibrationFlag
calibrationFlag = false;

global calInfo
calInfo = struct('addr', addr, 'output', {cell(32,32)}, 'slope', {cell(32,32)}, 'count', 0, 'closeFlag', 'false', 'farFlag', 'false');

dirs = dir('.\');
for i=3:length(dirs)
    if strcmp(dirs(i).name, calInfoFile)
        calInfo = load(calInfoFile);
        calInfo = calInfo.calInfo;
    end
end


global u
if isvalid(u)
    % 68 68 07 10 03 00 00 01 01
    fwrite(u,[...
        uint8(hex2dec('68')), ...
        uint8(hex2dec('68')), ...
        uint8(hex2dec(addrstr)), ...
        uint8(hex2dec('10')), ...
        uint8(hex2dec('03')), ...
        uint8(hex2dec('00')), ...
        uint8(hex2dec('00')), ...
        uint8(hex2dec('01')), ...
        uint8(hex2dec('01'))]);
else
end
    set(handles.pushbutton2,'Enable','off'); 
    set(handles.pushbutton3,'Enable','on'); 
    set(handles.pushbutton6,'Enable','on'); 
    set(handles.pushbutton7,'Enable','on'); 

guidata(hObject, handles);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global u
fclose(u);
delete(u)
set(handles.pushbutton2,'Enable','off'); 
set(handles.pushbutton3,'Enable','off'); 
set(handles.pushbutton6,'Enable','off'); 
set(handles.pushbutton7,'Enable','off'); 
% set(handles.pushbutton12,'Enable','off'); 
% set(handles.pushbutton13,'Enable','on'); 
global status
status = 'stop';

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global u
fwrite(u,[...
    uint8(hex2dec('68')), ...
    uint8(hex2dec('ff')), ...
    uint8(hex2dec('ff')), ...
    uint8(hex2dec('00')), ...
    uint8(hex2dec('00')), ...
    uint8(hex2dec('7f')), ...
    uint8(hex2dec('00')), ...
    uint8(hex2dec('00')), ...
    uint8(hex2dec('04')), ...
    uint8(hex2dec('00')), ...
    uint8(hex2dec('01')), ...
    uint8(hex2dec('00')), ...
    uint8(hex2dec('05')), ...
    uint8(hex2dec('00')), ...
    uint8(hex2dec('27')), ...
    uint8(hex2dec('1a'))]);
% M->S 68 FF FF 00 00 7F 00 00 04 00 01 00 05 00 27 1A
set(handles.pushbutton2,'Enable','on');
% set(handles.edit8,'string',dir2save);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
port2receive = '2007';
port2receive = str2double(port2receive);
global u
u = udpReceiveOpen(port2receive, handles);
if ~strcmp(u.Status, 'closed') 
    set(handles.pushbutton3,'Enable','on');
%     set(handles.pushbutton12,'Enable','on');
%     set(handles.pushbutton13,'Enable','off');
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pressurePoint
global count
global calibrationFlag
global pressureSum
if get(hObject,'Value')
    pressurePoint = 0;
    count = 0;
    calibrationFlag = true;
    pressureSum = zeros(32, 32);
end
% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pressurePoint
global count
global calibrationFlag
if get(hObject,'Value')
    pressurePoint = 1;
    count = 0;
    calibrationFlag = true;
end
% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pressurePoint
global count
global calibrationFlag
if get(hObject,'Value')
    pressurePoint = 2;
    count = 0;
    calibrationFlag = true;
end
% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pressurePoint
global count
global calibrationFlag
if get(hObject,'Value')
    pressurePoint = 3;
    count = 0;
    calibrationFlag = true;
end
% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pressurePoint
global count
global calibrationFlag
if get(hObject,'Value')
    pressurePoint = 4;
    count = 0;
    calibrationFlag = true;
end
% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global meshFlag
meshFlag = true;

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global meshFlag
meshFlag = false;

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global whichHalf
if get(hObject, 'Value')
    whichHalf = 'close';
end
% Hint: get(hObject,'Value') returns toggle state of checkbox1
set(handles.checkbox2, 'Value', 0);
set(handles.checkbox3, 'Value', 0);
set(handles.checkbox4, 'Value', 0);
set(handles.checkbox5, 'Value', 0);
set(handles.checkbox6, 'Value', 0);
set(handles.checkbox7, 'Value', 0);

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global whichHalf
if get(hObject, 'Value')
    whichHalf = 'far';
end
% Hint: get(hObject,'Value') returns toggle state of checkbox2
set(handles.checkbox1, 'Value', 0);
set(handles.checkbox3, 'Value', 0);
set(handles.checkbox4, 'Value', 0);
set(handles.checkbox5, 'Value', 0);
set(handles.checkbox6, 'Value', 0);
set(handles.checkbox7, 'Value', 0);

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global calInfo
global calInfoFile
calculateSlope(calInfo, calInfoFile);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
