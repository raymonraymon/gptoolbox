%crust_test

clc
clear
close all
dbstop if error
%%
xRes=10; yRes=10;
%[UV,F, res, edge_norms] = create_irregular_grid( xRes, yRes,'NumDarts',10,'NoInterior','1','MinAngle',30,'DartThreshold',0.95,'TriangleFlags','-q30,-a1.5');
[UV,F] = create_regular_grid(xRes, yRes);
%drawMesh(UV,F)

[CE,PC] = crust(UV);
drawMesh(UV,CE)

axis off

%%
[V,F]=subdivided_sphere(2);
color = 'white';
n=100;
[N,I,B,r] = random_points_on_mesh(V,F,n,'Color',color);
[CE,PC] = crust(N);
drawMesh(N,CE)