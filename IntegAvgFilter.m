% Average filter for noise removal that uses the Integral of the given image

% It's computationally faster, since the integral image is
% calculated once (which is all done using addition)
 
 
function [newImage] = IntegAvgFilter (imagePath, filterSize)
 
    % reading the image from the given path and showing it
    img = uint8(imread(imagePath));
    figure(1), clf, hold on
    subplot(1,2,1)
    imshow(img);
 
    [h,w] = size(img);
    integralImage = Integral(imagePath);
    newImage = img;
    delta = floor(filterSize/2);
 
    for i=filterSize:h
        for j=filterSize:w
 
            gridCorrect = 0;
            if i-filterSize > 0;
                gridCorrect = gridCorrect - integralImage(i-filterSize, j);
            end
            if j-filterSize > 0;
                gridCorrect = gridCorrect - integralImage(i, j-filterSize);
            end
            if i-filterSize > 0 && j-filterSize > 0;
                gridCorrect = gridCorrect + integralImage(i-filterSize, j-filterSize);
            end
 
            newImage(i-delta,j-delta) = uint8((integralImage(i,j) + gridCorrect)/(filterSize*filterSize));
        end
    end
 
    % writing the image to file
    last = find(imagePath == '/');
    folder_path = imagePath(1:last(end));
    new_file_name = strcat(folder_path, 'Camera_Filt_', num2str(filterSize), '.jpg');
    imwrite(newImage, new_file_name);
 
    % showing the image after filtering
    subplot(1,2,2)
    imshow(newImage);
end
