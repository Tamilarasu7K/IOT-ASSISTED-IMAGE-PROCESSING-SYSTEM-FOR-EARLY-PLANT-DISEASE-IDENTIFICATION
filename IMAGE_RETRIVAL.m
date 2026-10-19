function varargout = IMAGE_RETRIVAL(varargin)
% IMAGE_RETRIVAL MATLAB code for IMAGE_RETRIVAL.fig
%      IMAGE_RETRIVAL, by itself, creates a new IMAGE_RETRIVAL or raises the existing
%      singleton*.
%
%      H = IMAGE_RETRIVAL returns the handle to a new IMAGE_RETRIVAL or the handle to
%      the existing singleton*.
%
%      IMAGE_RETRIVAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGE_RETRIVAL.M with the given input arguments.
%
%      IMAGE_RETRIVAL('Property','Value',...) creates a new IMAGE_RETRIVAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IMAGE_RETRIVAL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IMAGE_RETRIVAL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IMAGE_RETRIVAL

% Last Modified by GUIDE v2.5 19-Sep-2013 11:19:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IMAGE_RETRIVAL_OpeningFcn, ...
                   'gui_OutputFcn',  @IMAGE_RETRIVAL_OutputFcn, ...
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


% --- Executes just before IMAGE_RETRIVAL is made visible.
function IMAGE_RETRIVAL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IMAGE_RETRIVAL (see VARARGIN)

% Choose default command line output for IMAGE_RETRIVAL
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IMAGE_RETRIVAL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IMAGE_RETRIVAL_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnimagedirectory.
function btnimagedirectory_Callback(hObject, eventdata, handles)
% hObject    handle to btnimagedirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir(pwd, 'Select the directory of images');
if ( folder_name ~= 0 )
    handles.folder_name = folder_name;
    guidata(hObject, handles);
else
    return;
end

% --- Executes on button press in btncreatedb.
function btncreatedb_Callback(hObject, eventdata, handles)
% hObject    handle to btncreatedb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global hsvimage;
global corrimage;
if (~isfield(handles, 'folder_name'))
    errordlg('Please select an image directory first!');
    return;
end

pngImagesDir = fullfile(handles.folder_name, '*.png');
jpgImagesDir = fullfile(handles.folder_name, '*.jpg');
bmpImagesDir = fullfile(handles.folder_name, '*.bmp');

num_of_png_images = numel( dir(pngImagesDir) );
num_of_jpg_images = numel( dir(jpgImagesDir) );
num_of_bmp_images = numel( dir(bmpImagesDir) );
totalImages = num_of_png_images + num_of_jpg_images + num_of_bmp_images;

jpg_files = dir(jpgImagesDir);
png_files = dir(pngImagesDir);
bmp_files = dir(bmpImagesDir);

if ( ~isempty( jpg_files ) || ~isempty( png_files ) || ~isempty( bmp_files ) )
    jpg_counter = 0;
    png_counter = 0;
    bmp_counter = 0;
    for k = 1:totalImages
       
      %  if ( (num_of_jpg_images - jpg_counter) > 0)
            imgInfoJPG = imfinfo( fullfile( handles.folder_name, jpg_files(jpg_counter+1).name ) )
             lower(imgInfoJPG.Format)
%             if ( strcmp( lower(imgInfoJPG.Format), 'jpg') == 1 )
%                 sprintf('%s \n', jpg_files(jpg_counter+1).name)
%                 image = imread( fullfile( handles.folder_name, jpg_files(jpg_counter+1).name ) );
%                 disimage = imresize(image,[200 200]);
%                 imshow(disimage,'Parent',handles.axes1);
%                 title(handles.axes1,'Input Images');
%                 
%                 dgray = rgb2gray(disimage);
%                 imshow(dgray,'Parent',handles.axes2);
%                 title(handles.axes2,'Gray Scale Images');
%                 
%                pause(0.1);
%                 [pathstr, name, ext] = fileparts( fullfile( handles.folder_name, jpg_files(jpg_counter+1).name ) );
%                 image = imresize(image, [384 256]);
%             end
%             
%             jpg_counter = jpg_counter + 1;
%             
%         elseif ( (num_of_png_images - png_counter) > 0)
%             imgInfoPNG = imfinfo( fullfile( handles.folder_name, png_files(png_counter+1).name ) );
%             if ( strcmp( lower(imgInfoPNG.Format), 'png') == 1 )
%                 sprintf('%s \n', png_files(png_counter+1).name)
%                image = imread( fullfile( handles.folder_name, png_files(png_counter+1).name ) );
%                   disimage = imresize(image,[200 200]);
%                imshow(disimage,'Parent',handles.axes1);
%                 title(handles.axes1,'Input Images');
%                 dgray = rgb2gray(disimage);
%                 imshow(dgray,'Parent',handles.axes2);
%                 title(handles.axes2,'Gray Scale Images');
%             %    pause(1);
%                 [pathstr, name, ext] = fileparts( fullfile( handles.folder_name, png_files(png_counter+1).name ) );
%                 image = imresize(image, [384 256]);
%             end
%             
%             png_counter = png_counter + 1;
%             
%         elseif ( (num_of_bmp_images - bmp_counter) > 0)
%             imgInfoBMP = imfinfo( fullfile( handles.folder_name, bmp_files(bmp_counter+1).name ) );
%             if ( strcmp( lower(imgInfoBMP.Format), 'bmp') == 1 )
%                  sprintf('%s \n', bmp_files(bmp_counter+1).name)
%                 image = imread( fullfile( handles.folder_name, bmp_files(bmp_counter+1).name ) );
%                   disimage = imresize(image,[200 200]);
%                 imshow(disimage,'Parent',handles.axes1);
%                 title(handles.axes1,'Input Images');
%                 dgray = rgb2gray(disimage);
%                 imshow(dgray,'Parent',handles.axes2);
%                 title(handles.axes2,'Gray Scale Images');
%             %    pause(1);
%                 [pathstr, name, ext] = fileparts( fullfile( handles.folder_name, bmp_files(bmp_counter+1).name ) );
%                 image = imresize(image, [384 256]);
%             end
              sprintf('%s \n', jpg_files(jpg_counter+1).name)
                image = imread( fullfile( handles.folder_name, jpg_files(jpg_counter+1).name ) );
                disimage = imresize(image,[200 200]);
                imshow(disimage,'Parent',handles.axes1);
                title(handles.axes1,'Input Images');
                
                dgray = rgb2gray(disimage);
                imshow(dgray,'Parent',handles.axes2);
                title(handles.axes2,'Gray Scale Images');
                
               pause(0.1);
                [pathstr, name, ext] = fileparts( fullfile( handles.folder_name, jpg_files(jpg_counter+1).name ) );
                image = imresize(image, [384 256]);
              jpg_counter = jpg_counter + 1;
            
   %     end
        
        hsvHist = hsvHistogram(image);
        disimage = imresize(hsvimage,[200 200]);
        imshow(disimage,'Parent',handles.axes3);
        title(handles.axes3,'HSV Images');
       pause(0.1);
        autoCorrelogram = colorAutoCorrelogram(image);
        disimage = imresize(corrimage,[200 200]);
        imshow(disimage,'Parent',handles.axes4);
        title(handles.axes4,'Color Auto Correlogram');
       pause(0.1);    
       input_im=double(image);          
       sigma_g=1.5;
       sigma_a=5;
       nPoints=30;
      [EnIm]= ColorHarris(input_im,sigma_g,sigma_a,0.04,1);
      [x_max,y_max,corner_im,num_max]=getmaxpoints(EnIm,nPoints);
       output_im=visualize_corners(input_im,corner_im);
       disimage = imresize(output_im,[200 200]);
        imshow(uint8(disimage),'Parent',handles.axes5);
        title(handles.axes5,'Color Feature Pts');
        pause(0.1);   
         color_moments = colorMoments(image);
       originalImage = image;
        [rows, columns, numberOfColorBands] = size(originalImage);
        if numberOfColorBands > 1
            originalImage = originalImage(:,:,2);
        end
        binaryImage = originalImage > 128;
        binaryImage = imclearborder(binaryImage);
        binaryImage = bwareaopen(binaryImage, 300);
        se = strel('disk', 3, 0);
        binaryImage = imclose(binaryImage, se);
        binaryImage = bwconvhull(binaryImage, 'objects');
        measurements = regionprops(binaryImage, 'Area', 'Centroid');
        allAreas = [measurements.Area]
        numberOfBlobs = length(allAreas)
        hold on;
        for k1 = 1 : numberOfBlobs
            thisCentroid = measurements(k1).Centroid
            plot(thisCentroid(1), thisCentroid(2), 'b+', 'MarkerSize', 10);
        end           
        distance = zeros(numberOfBlobs, numberOfBlobs);
         % disimage = imresize(binaryImage,[200 200]);
        imshow(binaryImage,'Parent',handles.axes6);
        hold on;
        title(handles.axes6,'Shape Features');
        for b1 = 1 : numberOfBlobs
            thisCentroid1 = measurements(b1).Centroid
            x1 = thisCentroid1(1);
            y1 = thisCentroid1(2);
            for b2 = (b1 + 1) : numberOfBlobs
                thisCentroid2 = measurements(b2).Centroid
                x2 = thisCentroid2(1);
                y2 = thisCentroid2(2);
                distance(b1,b2) = sqrt((x1-x2)^2+(y1-y2)^2);
                distance(b2,b1) = distance(b1,b2);
                line([x1 x2], [y1 y2], 'Color', 'r', 'LineWidth', 3);
                message = sprintf('This distance is %.3f', distance(b1,b2))
            end
        end
        pause(0.1)       
         a = image;
tmp = a; [m n]= find(a<50); 
for j = 1: length(m)  
    tmp(m(j),n(j))=0;
end
[m n]= find(a>50 & a <= 250);
for j = 1: length(m)   
    tmp(m(j),n(j))=0.8; 
end
[m n]= find(a>200);
for j = 1: length(m)   
    tmp(m(j),n(j))=0;
end
segimage2 = im2bw(tmp,0); 
level = graythresh(a);
segimage = im2bw(a,level);
[r c] = size(segimage);
for i=1:r
    for j=1:c
       aa = segimage(i,j);
       if(aa==0)
          image(i,j,:) = [0 0 0]; 
       end
        
    end    
end
disimage = imresize(image,[300 300]);
imshow(disimage,'Parent',handles.axes7);
hold on;
title(handles.axes7,'Segmentation');

pause(0.1)
        
        name
        
        img = double(rgb2gray(image))/255;
        [meanAmplitude, msEnergy] = gaborWavelet(img, 4, 6); % 4 = number of scales, 6 = number of orientations
        wavelet_moments = waveletTransform(image);
        set = [hsvHist autoCorrelogram color_moments meanAmplitude msEnergy wavelet_moments]
        dataset(k, :) = [set str2num(name)];
              
        clear('image', 'img', 'hsvHist', 'autoCorrelogram', 'color_moments', ...
            'gabor_wavelet', 'wavelet_moments', 'set', 'imgInfoJPG', 'imgInfoPNG', ...
            'imgInfoGIF');
    end
    
     uisave('dataset', 'dataset1');
  %  save('dataset.mat', 'dataset', '-mat');
    clear('dataset', 'jpg_counter', 'png_counter', 'bmp_counter');
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
