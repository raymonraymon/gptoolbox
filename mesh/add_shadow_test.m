close all
clc
clear

% [x,y] = meshgrid(1:15,1:15);
% tri = delaunay(x,y);
% z = peaks(15);
% T = trisurf(tri,x,y,z);
[V,F]=subdivided_sphere(2);

t = tsurf(F,V,'EdgeColor','none',fphong,'SpecularStrength',0.1);
l =  [...
    light('Position',[-10 -10 13],'Style','local');
    light('Position',[10 -10  13],'Style','local')];
camproj('persp'); axis equal; axis off;
add_lights();
h = add_shadow(t,l);
%apply_ambient_occlusion(t);