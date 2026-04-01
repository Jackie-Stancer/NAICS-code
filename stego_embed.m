function [out_image] = embed2(R2, G2, B2, P_com)

% Embed2 is Use LSB to embed the airport areas to Cb and Cr channel
% clear;clc
% load test1
    % read image (carrier)
    image_ycbcr = rgb2ycbcr(P_com);

    [h, w] = size(R2);
    bin_p = reshape(R2, h*w,1);
    bin_p(h*w+1:2*h*w, 1) = reshape(G2, h*w,1);
    bin_p(2*h*w+1:3*h*w, 1) = reshape(B2, h*w,1);
    bina_p = de2bi(bin_p, 8);
    p_bin = reshape(bina_p, 1, w*h*3*8);

    % extract blue-difference chroma
    cb = image_ycbcr(:, :, 2);
    cr = image_ycbcr(:, :, 3);

    [HH_height, HH_width] = size(cb);
    
    HH_flat = reshape(cb, [],1 );
    HL_flat = reshape(cr, [],1 );

    cb_bin = de2bi(HH_flat);
    cr_bin = de2bi(HL_flat);

    combinedMatrix = vertcat(cb_bin, cr_bin);

    num_points = w*h*3*8;
    total_pixels = HH_height * HH_width;
    interval = round(linspace(1, total_pixels, num_points+1));
    interval_min = min(interval(2)-interval(1), interval(num_points)-interval(num_points-1));
    
    
    overwhelmed = total_pixels < num_points;

    if (overwhelmed)
        disp('All bits length is too large to be embedded!');
    else

        for i = 1:num_points
            combinedMatrix(i,1) = p_bin(i);
        end

    end

    len = length(combinedMatrix);
    cb_debin = combinedMatrix(1:len/2, :);
    cr_debin = combinedMatrix(len/2+1:len, :);

    cb_de = bi2de(cb_debin);
    cr_de = bi2de(cr_debin);

    cb_re = reshape(cb_de, HH_height, HH_width);
    cr_re = reshape(cr_de, HH_height, HH_width);


    image_ycbcr(:, :, 2) = cb_re;
    image_ycbcr(:, :, 3) = cr_re;

    out_image = ycbcr2rgb(image_ycbcr);
    % imwrite(out_image, 'output.png');
    % 
    % figure
    % imshow(out_image);
    % title('stegano image');
end