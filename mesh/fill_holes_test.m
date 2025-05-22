
clc 
clear
close all
dbstop if error
s=100;r=5;  

[SV,SF] = readOBJ('..\models\halfsphereNotclose.obj');

% 
% HF = fill_holes(SV,SF);
% drawMesh(SV,[SF;HF],'FaceVertexCData',SV(:,1), 'facecolor','interp', 'edgecolor','k');
%         view(3);
%         axis equal
%         axis off
%         camlight
%         lighting gouraud
%         set(gca, 'Position',[0 0 1 1]);
%%        
 sigma = 2.0;
[vert, topo,sucess] = repair_hole(SV(ordered_outline(SF),:), sigma);
[vert, topo] = merge_mesh(vert, topo,SV,SF);
drawMesh(vert, topo)