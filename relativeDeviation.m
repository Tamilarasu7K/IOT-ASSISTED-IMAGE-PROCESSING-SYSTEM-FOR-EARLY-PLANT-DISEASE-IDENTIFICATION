function relativeDeviation(numOfReturnedImages, queryImageFeatureVector, dataset)
global result;
query_im_name = queryImageFeatureVector(:, end);
dataset_im_names = dataset(:, end);

queryImageFeatureVector(:, end) = [];
dataset(:, end) = [];


relDeviation = zeros(length(dataset), 1);
for k = 1:length(dataset)
    relDeviation(k) = sqrt( sum( power( dataset(k, :) - queryImageFeatureVector, 2 ) ) ) ./ 1/2 * ( sqrt( sum( power( dataset(k, :), 2 ) ) ) + sqrt( sum( power( queryImageFeatureVector, 2 ) ) ) );
end

relDeviation = [relDeviation dataset_im_names];

[sortRelDist indxs] = sortrows(relDeviation);
sortedRelImgs = sortRelDist(:, 2);


arrayfun(@cla, findall(0, 'type', 'axes'));

str_img_name = int2str(query_im_name);
query_im = imread( strcat('images\', str_img_name, '.jpg') );
subplot(3, 7, 1);
imshow(query_im, []);
title('Query Image', 'Color', [1 0 0]);
m=0;r=0;
for m = 1:numOfReturnedImages
    im_name = sortedRelImgs(m);
    im_name = int2str(im_name);
    t = str2num(img_name);
    if(t >= 0 && t <=9)
         m=m+1;
    else
       r=r+1;
    end
    str_im_name = strcat('images\', im_name, '.jpg');
    returned_im = imread(str_im_name);
    subplot(3, 7, m+1);
    imshow(returned_im, []);
end
if(m > r)   
    result = 'Mango Leaf';
else
      result = 'Rose Leaf';
end
end