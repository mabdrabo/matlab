% Generates the integral image of the given image

function [newImage, img] = Integral (imagePath)
 
    % reading the image from the given path and showing it
    img = imread(imagePath);
    figure(1), clf, hold on
    subplot(1,2,1)
    imshow(img);
 
    [h,w] = size(img);
    newImage = double(img);
 
    for i=1:h
        for j=2:w
            newImage(i,j) = newImage(i,j) + newImage(i,j-1);
        end
    end
    for j=1:w
        for i=2:h
            newImage(i,j) = newImage(i,j) + newImage(i-1,j);
        end
    end
 
    % writing the image to file
    last = find(imagePath == '/');
    folder_path = imagePath(1:last(end));
    new_file_name = strcat(folder_path, 'Camera_Integ.jpg');
    imwrite(newImage, new_file_name);
 
    % showing the image after filtering
    subplot(1,2,2)
    imshow(newImage);
 
end
