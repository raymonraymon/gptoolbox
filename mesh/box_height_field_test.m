    clc
    clear
    close all
    dbstop if error
    warning off all  
    
A = imread('BH4FLC.png');
[V,F]=box_height_field(A(:,:,1));
drawMesh(V,F)

%%
figure
RGB = imread('peppers.png');
imshow(RGB)
I = rgb2gray(RGB);
figure
imshow(I)

[V,F]=box_height_field(I(1:20:end,1:20:end));
figure;
drawMesh(V,F)