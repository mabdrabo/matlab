% the output of the bicubic interpolation is of higher quality than that of
% the nearest neighbour interpolation (the staircase effect is clearer).

% the bicubic interpolation is better in terms of quality, on the other
% hand it's more computationally expensive than the nearest neighbour
% interpolation, so the user should decide according to the application.

function [transformedImage, matlabImg] = bicubicRotation (imagePath, degree)

    % reading the image from the given path and showing it
    image = imread(imagePath);
    figure(1), clf, hold on
    subplot(1,3,1)
    imshow(image);

    % Convert to radians and create transformation matrix
    a = degree*pi/180;
    R = [+cos(a) +sin(a); -sin(a) +cos(a)];
    T1 = floor(size(image)/2 +1);

    % size of the transformed image and back translation value
    [m, n] = size(image);
    imagerot = zeros(n*sin(a) + m*cos(a), m*sin(a) + n*cos(a));
    T2 = floor(size(imagerot)/2 +1 );


    for i = 1:size(imagerot, 1)
        for j = 1:size(imagerot, 2)
            source = [i j]-T2;
            source = source*R.';
            source = source+T1;
            if all(source >= 2) && all(source+2 <= size(image)) % borders of the image
                % bicubic interpolation
                x_dash = source(1);
                y_dash = source(2);
                r = floor(x_dash);
                t = floor(y_dash);

                value = 0.0;
                for l=-1:2
                    for m=-1:2
                        temp = image(r+l, t+m);
                        x_dist = abs(r + l - x_dash);
                        y_dist = abs(t + m - y_dash);

                        if 0 <= x_dist && x_dist < 1
                            hx_3 = (1 -(2*x_dist^2)) +(x_dist^3);
                        elseif 1 <= x_dist && x_dist < 2
                            hx_3 = (4 -(8*x_dist) +(5*x_dist^2) -x_dist^3);
                        else
                            hx_3 = 0;
                        end
                        temp = temp*hx_3;

                        if 0 <= y_dist && y_dist < 1
                            hy_3 = (1 -(2*y_dist^2)) +(y_dist^3);
                        elseif 1 <= y_dist && y_dist < 2
                            hy_3 = temp * (4 -(8*y_dist) +(5*y_dist^2) -y_dist^3);
                        else
                            hy_3 = 0;
                        end
                        temp = temp*hy_3;

                        value = value + temp;
                    end
                end

                imagerot(i,j) = double(value);

            end
        end
    end
    
    % showing the image after rotation
    transformedImage = uint8(imagerot);
    subplot(1,3,2)
    imshow(transformedImage);
    
    % showing image after applying Matlab's imrotate{'nearest'}
    subplot(1,3,3)
    matlabImg = imrotate(image, degree, 'nearest');
    imshow(matlabImg);
    
    % writing the image to file
    last = find(imagePath == '/');
    folder_path = imagePath(1:last(end));
    new_file_name = strcat(folder_path, 'BarCodeRotated.bmp');
    imwrite(transformedImage, new_file_name);
end
