%laplacian_mesh_editing_test_2d
clc;
close all;
clear ;
dbstop if error ;
warning('off');

xRes = 3;
  yRes = 3;
  
  wrap = 0;

[vertex,faces,res,edge_norms] = create_regular_grid(xRes,yRes,wrap,wrap);

BI = [1  600];
BC = vertex(BI,:)+rand(length(BI),2);

U = laplacian_mesh_editing(vertex,faces,BI,BC);

drawMesh(vertex,faces);
hold on 
drawMesh(U,faces);