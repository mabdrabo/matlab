% a function to increase the contrast of any gray-scale image.
% The function takes as inputs the gray-scale image in addition to the parameters A, B, C and D.
% The function outputs the transformed image.

function [transformedImage] = incContrast (imagePath, A, B, C, D)
    x1 = A;
    y1 = B;
    x2 = C;
    y2 = D;
    x3 = 255;
    y3 = 255;
    img = double(imread(imagePath));
 
    m1 = (y1 - 0) / (x1 - 0);
    m2 = (y2 - y1) / (x2 - x1);
    m3 = (y3 - y2) / (x3 - x2);
 
    c2 = y2 - (m2 * x2);
    c3 = y3 - (m3 * x3);
 
    [h,w] = size(img);
    for i=1:h
        for j=1:w
            if img(i, j) <= x1;
                newValue = (img(i, j) * m1);
            elseif img(i, j) <= x2;
                newValue = (img(i, j) * m2) + c2;
            elseif img(i, j) <= 255;
                newValue = (img(i, j) * m3) + c3;
            end
            if newValue > 255;
                newValue = 255;
            end
            img(i, j) = newValue;
        end
    end
    img = uint8(img);
    
    last = find(imagePath == '/');
    folder_path = imagePath(1:last(end));
    new_file_name = strcat(folder_path, 'Output_image', '.bmp');
    imwrite(img, new_file_name);
    
    imshow(img);
    transformedImage = img;
end
