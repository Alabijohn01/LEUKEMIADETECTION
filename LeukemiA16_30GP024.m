function varargout = LeukemiA16_30GP024(varargin)
% LEUKEMIA16_30GP024 MATLAB code for LeukemiA16_30GP024.fig
%      LEUKEMIA16_30GP024, by itself, creates a new LEUKEMIA16_30GP024 or raises the existing
%      singleton*.
%
%      H = LEUKEMIA16_30GP024 returns the handle to a new LEUKEMIA16_30GP024 or the handle to
%      the existing singleton*.
%
%      LEUKEMIA16_30GP024('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEUKEMIA16_30GP024.M with the given input arguments.
%
%      LEUKEMIA16_30GP024('Property','Value',...) creates a new LEUKEMIA16_30GP024 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LeukemiA16_30GP024_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LeukemiA16_30GP024_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LeukemiA16_30GP024

% Last Modified by GUIDE v2.5 12-Nov-2021 23:14:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LeukemiA16_30GP024_OpeningFcn, ...
                   'gui_OutputFcn',  @LeukemiA16_30GP024_OutputFcn, ...
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


% --- Executes just before LeukemiA16_30GP024 is made visible.
function LeukemiA16_30GP024_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LeukemiA16_30GP024 (see VARARGIN)

% Choose default command line output for LeukemiA16_30GP024
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LeukemiA16_30GP024 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LeukemiA16_30GP024_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadImg.
function loadImg_Callback(hObject, eventdata, handles)
    [file,path] = uigetfile({'*.jpg'; '*.png'}, 'Select An Image');
     if isequal(file,0)
       disp('User selected Cancel');
     else  
      selectedfile = fullfile(path,file);
   %%Reading in the image
       myImage = imread(selectedfile);
       %% calling function
     
     cellsSegmentation(handles, myImage, "rgb");
     cellsSegmentation(handles, myImage, "cmyk");
     cellsSegmentation(handles, myImage, "ycbcr");
     %% message popup
   
     success = msgbox('Process done.','Success');
     end
function myImage = convertColorSpace(color, myImage)
% convert RGB to other color space
if color == "cmyk"
        cform = makecform('srgb2cmyk');
        myImage = applycform(myImage,cform); 
        myImage = myImage(:,:,1:3);
elseif color == "ycbcr"
        myImage = rgb2ycbcr(myImage);
else
        myImage = myImage;
end
% hObject    handle to loadImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in captureImg.
function captureImg_Callback(hObject, eventdata, handles)
%% declaring handles as a global variable
 
global vid;
inputimage = getsnapshot(vid);


stop(vid);

flushdata(vid);
cla;

set(handles.captureImg,'Visible','off');
cellsSegmentation(handles, inputimage, "rgb");
cellsSegmentation(handles, inputimage, "cmyk");
cellsSegmentation(handles, inputimage, "ycbcr");

%% Show message topup
success = msgbox('Process done.','SUCCESS');



% hObject    handle to captureImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of captureImg

function cellsSegmentation(handles, myImage, colorspace)
% CONVERT INTO THE 3 COLOR SPACES
myImage = convertColorSpace(colorspace, myImage);

%% WHITE BLOOD CELLS
if colorspace == "cmyk"
        axes(handles.cmyk1);
        WBC = handles.wbcCMYK;
        RBC = handles.rbcCMYK;
elseif colorspace == "ycbcr"
        axes(handles.ycbcr1);
        WBC = handles.wbcYCbCr;
        RBC = handles.rbcYCbCr;
else
        axes(handles.rgb1);
        WBC = handles.wbcRGB;
        RBC = handles.rbcRGB;
end
imshow(myImage);
set(handles.wbcText, 'string', 'Loaded Blood Smears Image');
pause(1);

%%Extracting the blue plane 
if colorspace == "cmyk"
    bPlane = myImage(:,:,1)- 0.4*(myImage(:,:,3)) - 0.6*(myImage(:,:,2));
else
    bPlane = myImage(:,:,3)  - 0.5*(myImage(:,:,1)) - 0.5*(myImage(:,:,2));
end
imshow(bPlane);
set(handles.wbcText, 'string', 'Extracted White Blood Cells');
pause(1);

%%Extract out WHITE cells
BW = bPlane > 29;
imshow(BW);
set(handles.wbcText, 'string', 'Enhanced Image');
pause(1);

%%Remove noise 100 pixels or less
BW2 = bwareaopen(BW, 100);
imshow(BW2);
set(handles.wbcText, 'string', 'Noise Removed');
pause(1);
%%Calculate area of regions
cellStats = regionprops(BW2, 'all');
cellAreas = [cellStats(:).Area];

imshow(myImage), hold on

%% Label connected components
[L Ne]=bwlabel(BW2);
propied=regionprops(L,'BoundingBox'); 
himage = imshow(BW2);

%% Get the totalcellsRGB number of cells that have been added with bounding box
whitecount = size(propied,1);

%% Added bounding box to the white blood cells
hold on
for n=1:whitecount
  rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end
hold off

%% Superimpose the two image
set(himage, 'AlphaData', 0.5);

%% set totalcellsRGB white blood cells detected
set(handles.wbcText, 'string', 'Process Done');
set(WBC, 'string', whitecount);
pause(2);


%% RED BLOOD CELLS
if colorspace == "cmyk"
        axes(handles.cmyk2);
elseif colorspace == "ycbcr"
        axes(handles.ycbcr2);
else
        axes(handles.rgb2);
end
imshow(myImage);
set(handles.rbcText, 'string', 'Loaded Blood Smears Image');
pause(1);

%% Extracting the red plane 
if colorspace == "cmyk"
    rPlane = myImage(:,:,3)  - 0.5*(myImage(:,:,1)) - 0.5*(myImage(:,:,2));
else
    rPlane = myImage(:,:,1)- 0.4*(myImage(:,:,3)) - 0.6*(myImage(:,:,2));
end
imshow(rPlane);
set(handles.rbcText, 'string', 'Extracted Red Blood Cells');
pause(1);

%% Extract out red cells
BWr = rPlane > 19;
imshow(BWr);
set(handles.rbcText, 'string', 'Enhanced Image');
pause(1);

%%Remove noise 100 pixels or less
BWr2 = bwareaopen(BWr, 100);
imshow(BWr2);
set(handles.rbcText, 'string', 'Noise Removed');
pause(1);
%%Calculate area of regions
cellStatsr = regionprops(BWr2, 'all');
cellAreasr = [cellStatsr(:).Area];

%% create new figure to output superimposed images
% first display the original image
imshow(myImage), hold on

%% Label connected components
[Lred Nered]=bwlabel(BWr2);
propiedr=regionprops(Lred,'BoundingBox'); 
himagered = imshow(BWr2);

%% Get the totalcellsRGB number of cells that have been added with bounding box
redcount = size(propiedr,1);

%% Added bounding box to the red blood cells
hold on
for n=1:redcount
  rectangle('Position',propiedr(n).BoundingBox,'EdgeColor','r','LineWidth',2)
end
hold off

%% To Superimpose the two image
set(himagered, 'AlphaData', 0.5);

%% set totalcellsRGB white blood cells detected
set(handles.rbcText, 'string', 'Process Done');
set(RBC, 'string', redcount);
pause(1);

%% Calculate percentages
totalCells = whitecount + redcount;
wbcPercent = (whitecount ./ totalCells) .* 100;
rbcPercent = (redcount ./ totalCells) .* 100;

if colorspace == "cmyk" 
    totalCellsHandle = handles.totalcellsCMYK;
    WBCPercentHandle = handles.wbcpercentCMYK;
    RBCPercentHandle = handles.rbcpercentCMYK;
    resultTextHandle = handles.resultTextCMYK;
elseif colorspace == "ycbcr"
    totalCellsHandle = handles.totalcellsYCbCr;
    WBCPercentHandle = handles.wbcpercentYCbCr;
    RBCPercentHandle = handles.rbcpercentYCbCr;
    resultTextHandle = handles.resultTextYCbCr;    
else
    totalCellsHandle = handles.totalcellsRGB;
    WBCPercentHandle = handles.wbcpercentRGB;
    RBCPercentHandle = handles.rbcpercentRGB;
    resultTextHandle = handles.resultTextRGB;
end

set(totalCellsHandle, 'string', totalCells);
set(WBCPercentHandle, 'string', sprintf('%i%%',vpa(wbcPercent)));
set(RBCPercentHandle, 'string', sprintf('%i%%',vpa(rbcPercent)));

if vpa(wbcPercent) >= 10
    set(resultTextHandle, 'string', 'POTENTIAL LEUKEMIA DETECTED');
else
    set(resultTextHandle, 'string', 'NORMAL');
end





function wbcRGB_Callback(hObject, eventdata, handles)
% hObject    handle to wbcRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wbcRGB as text
%        str2double(get(hObject,'String')) returns contents of wbcRGB as a double


% --- Executes during object creation, after setting all properties.
function wbcRGB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wbcRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rbcRGB_Callback(hObject, eventdata, handles)
% hObject    handle to rbcRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rbcRGB as text
%        str2double(get(hObject,'String')) returns contents of rbcRGB as a double


% --- Executes during object creation, after setting all properties.
function rbcRGB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rbcRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function totalcellsRGB_Callback(hObject, eventdata, handles)
% hObject    handle to totalcellsRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of totalcellsRGB as text
%        str2double(get(hObject,'String')) returns contents of totalcellsRGB as a double


% --- Executes during object creation, after setting all properties.
function totalcellsRGB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totalcellsRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wbcYCbCr_Callback(hObject, eventdata, handles)
% hObject    handle to wbcYCbCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wbcYCbCr as text
%        str2double(get(hObject,'String')) returns contents of wbcYCbCr as a double


% --- Executes during object creation, after setting all properties.
function wbcYCbCr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wbcYCbCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wbcCMYK_Callback(hObject, eventdata, handles)
% hObject    handle to wbcCMYK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wbcCMYK as text
%        str2double(get(hObject,'String')) returns contents of wbcCMYK as a double


% --- Executes during object creation, after setting all properties.
function wbcCMYK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wbcCMYK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rbcYCbCr_Callback(hObject, eventdata, handles)
% hObject    handle to rbcYCbCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rbcYCbCr as text
%        str2double(get(hObject,'String')) returns contents of rbcYCbCr as a double


% --- Executes during object creation, after setting all properties.
function rbcYCbCr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rbcYCbCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rbcCMYK_Callback(hObject, eventdata, handles)
% hObject    handle to rbcCMYK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rbcCMYK as text
%        str2double(get(hObject,'String')) returns contents of rbcCMYK as a double


% --- Executes during object creation, after setting all properties.
function rbcCMYK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rbcCMYK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wbcpercentRGB_Callback(hObject, eventdata, handles)
% hObject    handle to wbcpercentRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wbcpercentRGB as text
%        str2double(get(hObject,'String')) returns contents of wbcpercentRGB as a double


% --- Executes during object creation, after setting all properties.
function wbcpercentRGB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wbcpercentRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rbcpercentRGB_Callback(hObject, eventdata, handles)
% hObject    handle to rbcpercentRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rbcpercentRGB as text
%        str2double(get(hObject,'String')) returns contents of rbcpercentRGB as a double


% --- Executes during object creation, after setting all properties.
function rbcpercentRGB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rbcpercentRGB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function totalcellsYCbCr_Callback(hObject, eventdata, handles)
% hObject    handle to totalcellsYCbCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of totalcellsYCbCr as text
%        str2double(get(hObject,'String')) returns contents of totalcellsYCbCr as a double


% --- Executes during object creation, after setting all properties.
function totalcellsYCbCr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totalcellsYCbCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function totalcellsCMYK_Callback(hObject, eventdata, handles)
% hObject    handle to totalcellsCMYK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of totalcellsCMYK as text
%        str2double(get(hObject,'String')) returns contents of totalcellsCMYK as a double


% --- Executes during object creation, after setting all properties.
function totalcellsCMYK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totalcellsCMYK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rbcpercentCMYK_Callback(hObject, eventdata, handles)
% hObject    handle to rbcpercentCMYK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rbcpercentCMYK as text
%        str2double(get(hObject,'String')) returns contents of rbcpercentCMYK as a double


% --- Executes during object creation, after setting all properties.
function rbcpercentCMYK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rbcpercentCMYK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wbcpercentCMYK_Callback(hObject, eventdata, handles)
% hObject    handle to wbcpercentCMYK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wbcpercentCMYK as text
%        str2double(get(hObject,'String')) returns contents of wbcpercentCMYK as a double


% --- Executes during object creation, after setting all properties.
function wbcpercentCMYK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wbcpercentCMYK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rbcpercentYCbCr_Callback(hObject, eventdata, handles)
% hObject    handle to rbcpercentYCbCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rbcpercentYCbCr as text
%        str2double(get(hObject,'String')) returns contents of rbcpercentYCbCr as a double


% --- Executes during object creation, after setting all properties.
function rbcpercentYCbCr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rbcpercentYCbCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wbcpercentYCbCr_Callback(hObject, eventdata, handles)
% hObject    handle to wbcpercentYCbCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wbcpercentYCbCr as text
%        str2double(get(hObject,'String')) returns contents of wbcpercentYCbCr as a double


% --- Executes during object creation, after setting all properties.
function wbcpercentYCbCr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wbcpercentYCbCr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
