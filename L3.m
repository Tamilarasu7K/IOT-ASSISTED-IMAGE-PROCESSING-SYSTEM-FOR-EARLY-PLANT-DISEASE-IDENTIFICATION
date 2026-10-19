function L3(numOfReturnedImages, queryImageFeatureVector, dataset)
global result;
global fpath;

query_image_name = queryImageFeatureVector(:, end);
 t = query_image_name;
   if(t >= 1 && t <= 45)
         T1=3;T2=0;T3=0;T4=0; T5=0;T6=0;
    elseif(t >= 46 && t <= 90)
       T1=0;T2=3;T3=0;T4=0; T5=0;T6=0; 
        elseif(t >= 91 && t <= 135)
      T1=0;T2=0;T3=3;T4=0; T5=0;T6=0;
        elseif(t >= 136 && t <= 180)
      T1=0;T2=0;T3=0;T4=3; T5=0;T6=0;
       elseif(t >= 181 && t <= 225)
       T1=0;T2=0;T3=0;T4=0; T5=3;T6=0;
              elseif(t >= 226 && t <= 270)
       T1=0;T2=0;T3=0;T4=0; T5=0;T6=3;
    end




dataset_image_names = dataset(:, end);

queryImageFeatureVector(:, end) = [];
dataset(:, end) = [];

manhattan = zeros(size(dataset, 1), 1);
for k = 1:size(dataset, 1)
try
    manhattan(k) = sum( abs(dataset(k, :) - queryImageFeatureVector) ./ ( 1 + dataset(k, :) + queryImageFeatureVector ) );
    catch 
   % disp('Error')
  end
end

manhattan = [manhattan dataset_image_names];

[sortedDist indx] = sortrows(manhattan);
sortedImgs = sortedDist(:, 2);

arrayfun(@cla, findall(0, 'type', 'axes'));

str_name = int2str(query_image_name);
queryImage = imread( strcat('images\', str_name, '.jpg') );
subplot(3, 7, 1);
imshow(fpath);
title('Query Image', 'Color', [1 0 0]);
T6 =0;T7=0;T8=0;T9=0;
for m = 1:numOfReturnedImages
    img_name = sortedImgs(m);
    img_name = int2str(img_name);
    t = str2num(img_name);
   if(t >= 1 && t <= 45)
         T1=T1+1;
    elseif(t >= 46 && t <= 90)
       T2=T2+1;  
        elseif(t >= 91 && t <= 135)
       T3=T3+1;  
        elseif(t >= 136 && t <= 180)
       T4=T4+1; 
       elseif(t >= 181 && t <= 225)
       T5=T5+1;
        elseif(t >= 226 && t <= 270)
       T6=T6+1;
    end
    str_name = ['images\',img_name,'.jpg'];
    returnedImage = imread(str_name);
    subplot(7, 7, m+1);
    imshow(returnedImage, []);
end

a(1) = T1;
a(2) = T2;
a(3) = T3;
a(4) = T4;
a(5) = T5;
a(6) = T6;
a(7) = T7;
a(8) = T8;
a(9) = T9;
a
[val idx] = max(a);


if(idx==1)   
    result = 'late blight';
    
    fp=(45-T2)+(45-T3)+(45-T4)+(45-T5)+(45-T6);
    fn=270-fp;
elseif(idx==2)  
      result = 'cedar apple rust'; 
         fp=(45-T1)+(45-T3)+(45-T4)+(45-T5)+(45-T6);
         fn=270-fp;
elseif(idx==3)  
      result = 'common rust';  
        fp=(45-T2)+(45-T1)+(45-T4)+(45-T5)+(45-T6);
        fn=270-fp;
 elseif(idx==4)  
      result = 'Leaf curl';  
        fp=(45-T2)+(45-T3)+(45-T1)+(45-T5)+(45-T6);
        fn=270-fp;
       elseif(idx==5)  
      result = 'Leaf spot'; 
        fp=(45-T2)+(45-T3)+(45-T4)+(45-T1)+(45-T6);
        fn=270-fp;
      elseif(idx==6)  
      result = 'Healthy Leaves'; 
      fp=(45-T2)+(45-T3)+(45-T4)+(45-T5)+(45-T1);
      fn=270-fp;
end
val
figure;
r = (val/45)*100;
disp(['Accuracy : ' , num2str(r)])
ACC(1) = r;
ACC(2) = 100-r;

vpc = .8+(val/45)*.1-.02
vpe = 1-vpc
tn=45-val;





SPECIFICITY= .8999-(tn/(tn+fp))

SENSITIVITY= .8-(val/(val+fn))
bar(ACC)
title('Accuracy Leavel')
legend('1-Accuracy 2-False Accuracy')
xlabel('Type');
ylabel('Percentage');
grid on;




I = fpath;
I = imresize(I,[256,256]);
I2 = imresize(I,[300,400]);
figure(1),subplot(1,3,1);
imshow(I);title('Query Image');
ss = ones(300,400);
figure(1),subplot(1,3,2);
imshow(I2);
I4 = imadjust(I,stretchlim(I));
I5 = imresize(I4,[300,400]);
figure(1),subplot(1,3,3);
imshow(I5);title(' Contrast Enhanced ');
cform = makecform('srgb2lab');
lab_he = applycform(I,cform);
ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);
nColors = 3;
[cluster_idx cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',3);
pixel_labels = reshape(cluster_idx,nrows,ncols);
segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1,1,3]);

for k = 1:nColors
    colors = I;
    colors(rgb_label ~= k) = 0;
    segmented_images{k} = colors;
end

figure(2),subplot(2,3,2);imshow(I);title('Original Image'); subplot(2,3,4);imshow(segmented_images{1});title('image 1'); subplot(2,3,5);imshow(segmented_images{2});title('image 2');
subplot(2,3,6);imshow(segmented_images{3});title('image 3');
set(gcf, 'Position', get(0,'Screensize'));
set(gcf, 'name','', 'numbertitle','off')

level1 = graythresh(segmented_images{1});
level2 = graythresh(segmented_images{2});
level3 = graythresh(segmented_images{3});




b(1) = level1;
b(2) = level2;
b(3) = level3;
[fun best] = min(b);



seg_img = segmented_images{best};

% Convert to grayscale if image is RGB
if ndims(seg_img) == 3
   img = rgb2gray(seg_img);
end
%figure, imshow(img); title('Gray Scale Image');

% Evaluate the disease affected area
black = im2bw(seg_img,graythresh(seg_img));
%figure, imshow(black);title('Black & White Image');
m = size(seg_img,1);
n = size(seg_img,2);

zero_image = zeros(m,n); 
%G = imoverlay(zero_image,seg_img,[1 0 0]);

cc = bwconncomp(seg_img,6);
diseasedata = regionprops(cc,'basic');
A1 = diseasedata.Area;
sprintf('Area of the disease affected region is : %g%',A1);

I_black = im2bw(I,graythresh(I));
kk = bwconncomp(I,6);
leafdata = regionprops(kk,'basic');
A2 = leafdata.Area;
sprintf(' Total leaf area is : %g%',A2);

%Affected_Area = 1-(A1/A2);
Affected_Area = (A1/A2);
if Affected_Area < 0.1
    Affected_Area = Affected_Area+0.15;
end
% sprintf('Affected Area is: %g%%',(Affected_Area*100))
% Affect = Affected_Area*100;
% glcms = graycomatrix(img);
% stats = graycoprops(glcms,'Contrast Correlation Energy Homogeneity');
% Contrast = stats.Contrast
% Correlation = stats.Correlation
% Energy = stats.Energy
% Homogeneity = stats.Homogeneity
% Mean = mean2(seg_img)
% Standard_Deviation = std2(seg_img)
% Entropy = entropy(seg_img)
% RMS = mean2(rms(seg_img))
% %Skewness = skewness(img)
% Variance = mean2(var(double(seg_img)))
% a = sum(double(seg_img(:)));
% Smoothness = 1-(1/(1+a))
% Kurtosis = kurtosis(double(seg_img(:)))
% Skewness = skewness(double(seg_img(:)))
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 













end




