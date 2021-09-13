%laplacian_mesh_editing_test_2d
clc;
close all;
clear ;
dbstop if error ;
warning('off');

xRes = 32;
  yRes = 32;
  
  wrap = 0;

[vertex,faces,res,edge_norms] = create_regular_grid(xRes,yRes,wrap,wrap);
BI = [1 4 5 6];
BC = vertex(BI,:)+rand(length(BI),2);

U = laplacian_mesh_editing(vertex,faces,BI,BC);

drawMesh(vertex,faces);
hold on 
drawMesh(U,faces);