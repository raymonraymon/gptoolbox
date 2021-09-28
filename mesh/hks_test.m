close all
clc
clear

[V,F] = subdivided_sphere(3);
    drawMesh(V,F);
    [K,MK] = hks(V,F);
    % Compare all vertices' signatures to first using metric of [Sun et al.
    % 2009]
    k = bsxfun(@minus,K,K(1,:));
    tsurf(F,V,'CData',sqrt(sum(bsxfun(@rdivide,k,MK).^2,2)),fphong);
    
    view(3);
    axis equal
    axis off
    camlight
    lighting gouraud
    set(gca, 'Position',[0 0 1 1]);