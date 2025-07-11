% [D] = geodesics_in_heat(V, F, src)
clc
clear
close all
dbstop if error
warning off all
[V,F] = subdivided_sphere(2);
src =[120];
[D] = geodesics_in_heat(V, F, src) ;

drawMesh(V,F,'FaceVertexCData',D, 'facecolor','interp', 'edgecolor','k')
view(3);
axis equal
axis off
camlight
lighting gouraud
set(gca, 'Position',[0 0 1 1]);