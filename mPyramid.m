% A function that produces the M-pyramid for the given image, using the integral image function.
% M-pyramid function takes the gray-scale image as an input and outputs the 9 M images

function [] = mPyramid (imagePath)
 
    % reading the image from the given path and showing it
    img = uint8(imread(imagePath));
    figure(1), clf, hold on
    subplot(3,3,1)
    imshow(img);
    
    impath = imagePath;
    [h,w] = size(img);
    
    last = find(imagePath == '/');
    folder_path = imagePath(1:last(end));
    new_file_name = strcat(folder_path, 'M0.jpg');
    imwrite(img, new_file_name);
 
    counter = 1;
    while counter < 9
        integralImage = Integral(impath);
        [y,x] = size(integralImage);
        newImage = zeros([y/2,x/2]);
        newImage = im2uint8(newImage);
        new_i = 1;
        new_j = 1;
        for i=2:2:y
            for j=2:2:x
                gridCorrect = 0;
                if i-2 > 0;
                    gridCorrect = gridCorrect - integralImage(i-2, j);
                end
                if j-2 > 0;
                    gridCorrect = gridCorrect - integralImage(i, j-2);
                end
                if i-2 > 0 && j-2 > 0;
                    gridCorrect = gridCorrect + integralImage(i-2, j-2);
                end
                newImage(new_i,new_j) = uint8((integralImage(i,j) + gridCorrect)/4);
                new_j = new_j + 1;
            end
            new_j = 1;
            new_i = new_i + 1;
        end
        
        % writing the image to file
        last = find(imagePath == '/');
        folder_path = imagePath(1:last(end));
        new_file_name = strcat(folder_path, 'M', num2str(counter), '.jpg');
        imwrite(newImage, new_file_name);
        impath = new_file_name;
        
        % showing the image after filtering
        subplot(3,3,counter)
        imshow(newImage);
        counter = counter + 1;
    end
        
end
