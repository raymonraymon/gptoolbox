  % Read in image, convert to binary, shrink, invert
    im = ~imresize(im2bw(imread('hans-hass.jpg')),0.25);
    % Pad image to create boundary frame
    im = padarray(im,ceil(max(size(im))*0.125*[1;1]));
    % Generate stencil of thickness = 1px
    [V,F] = bwstencil(im,'Tol',1.5,'SmoothingIters',50);
    % Change thickness to 2.5% size of image
    V(:,3) = V(:,3) * 0.025*max(size(im));
    % render result:
    subplot(2,1,1);
    imshow(im);
    subplot(2,1,2);
    tsurf(F,V,'EdgeColor','none','FaceColor',[0.3 0.4 1.0],'FaceAlpha',0.9);
    l = light('Style','infinite','Position',[0.3 0.2 1]);
    axis equal;