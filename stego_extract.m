function [R2,G2,B2] = embed2_extract(image, w, h)
% Extracts text from the given input image using DWT.
% clear;clc;
%   image = imread('001_en.png');
    %noise
    % image = imnoise(image, 'salt & pepper', 0.01);
    % convert to YCbCr color space
    image_ycbcr = rgb2ycbcr(image);

    % extract blue-difference chroma
    cb = image_ycbcr(:, :, 2);
    cr = image_ycbcr(:, :, 3);

    cb_de = reshape(cb, 1, []);
    cr_de = reshape(cb, 1, []);

    cb_debin = de2bi(cb_de);
    cr_debin = de2bi(cr_de);

    combinedMatrix = vertcat(cb_debin, cr_debin);

    % w = 63;
    % h = 93;
    num_points = w*h*3*8;

    for i = 1:num_points
            p_bin(i)= combinedMatrix(i,1);
    end

    bina_p = reshape(p_bin, w*h*3, 8);
    bin_p = bi2de(bina_p);
    
    R2 = reshape(bin_p(1:h*w, 1), h, w);
    G2 = reshape(bin_p(h*w+1:2*h*w, 1), h, w);
    B2 = reshape(bin_p(2*h*w+1:3*h*w, 1), h, w);

    % airport = cat(3, R2,G2,B2);

   
end

