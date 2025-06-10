%[UV,F, res, edge_norms] = create_irregular_grid( xRes, yRes, varargin)

clc
clear
close all
dbstop if error
%%
xRes=10; yRes=10;
[UV,F, res, edge_norms] = create_irregular_grid( xRes, yRes,'NumDarts',10,'NoInterior','1','MinAngle',30,'DartThreshold',0.95,'TriangleFlags','-q30,-a1.5');

drawMesh(UV,F)