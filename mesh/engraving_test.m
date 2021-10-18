 % load image
   im = imresize(rgb2gray(im2double(imread('hans-hass.jpg'))),0.5);
   % pad image by 10% of width
   im = padarray(im,ceil(0.1*repmat(size(im,2),1,2)));
   % engrave: 50mm wide, 5mm thick, 1mm devoted to 4 layers
   [V,F] = engraving(im,50,5,1,4);
  drawMesh(V,F)