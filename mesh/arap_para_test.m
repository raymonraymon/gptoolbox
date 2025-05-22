
clear
close all
clc
dbstop if error
%%
%[V,F]=readOBJ('..\models\halfsphereNotclose.obj');
xRes = 32;
  yRes = 32;
  % here we tell the function that we want a disc topology
  wrap = 0;
  % Output:
  %  F: list of triangles, each row is 3 indices to vertex list, thus #triangles x 3 array
  %  V: list of vertex positions #vertices x 2 array, (2D so far)
  %  res: legacy value
  %  edge_norms: list of norms for each edge, ordered like F for edges opposite
  %              vertex index, thus #triangles x 3 array
  [V,F,res,edge_norms] = create_regular_grid(xRes,yRes,wrap,wrap);
figure;
drawMesh(V,F,'FaceAlpha',.5);
b=[1,xRes];
bc =[0 0;1 1];
%%
[U,udata] = arap(V,F,b,bc,'Energy','elements','Flat',true);

drawMesh(U,F);
view(3)
%zoom out
%zoom(1.5)
title('arap solution');
axis equal; 
axis vis3d;