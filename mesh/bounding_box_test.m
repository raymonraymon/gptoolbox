clc
clear
close all
dbstop if error
warning off all

[V,F] = subdivided_sphere(1);
drawMesh(V,F);
[BB,BF,BQ] = bounding_box(V,'Epsilon',0.02);

drawMesh(BB,BF,'facealpha',0.5);

view(3);
axis equal
axis off
camlight
lighting gouraud
set(gca, 'Position',[0 0 1 1]);