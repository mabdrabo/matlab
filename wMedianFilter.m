% The output of the weighted median filter is less blurry than that of the 
% normal median filter.

% The weighted median filter is better, since it gives most weight to the
% chosen pixel, slightly less weight to close pixels and far less for
% further pixels, and that how the blurr is decreased.

function [transformedImage, v] = wMedianFilter (imagePath)
    
    % reading the image from the given path and showing it
    w = [1 3 1; 3 5 3; 1 3 1];
    img = uint8(imread(imagePath));
    figure(1), clf, hold on
    subplot(1,2,1)
    imshow(img);
    
    [h,w] = size(img);
    transformedImage = img;
    v = zeros(5,1);
    
    for i=2:h-1
        for j=2:w-1
            % appending the values of the mask
            v = [];
            v = [v, img(i-1, j-1)];
            v = [v, img(i-1, j), img(i-1, j), img(i-1, j)];
            v = [v, img(i-1, j+1)];
            
            v = [v, img(i, j-1), img(i, j-1), img(i, j-1)];
            v = [v, img(i, j), img(i, j), img(i, j), img(i, j), img(i, j)];
            v = [v, img(i, j+1), img(i, j+1), img(i, j+1)];
            
            v = [v, img(i+1, j-1)];
            v = [v, img(i+1, j), img(i+1, j), img(i+1, j)];
            v = [v, img(i+1, j+1)];
            
            transformedImage(i,j) = median(double(v));
        end
    end
    
    % writing the image to file
    last = find(imagePath == '/');
    folder_path = imagePath(1:last(end));
    new_file_name = strcat(folder_path, 'BarCodeWeighted.jpg');
    imwrite(transformedImage, new_file_name);
    
    % showing the image after filtering
    subplot(1,2,2)
    imshow(transformedImage);
end
