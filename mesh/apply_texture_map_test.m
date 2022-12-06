close all
clc;
clear;
dbstop if error;

%%
   [x,y] = meshgrid(1:15,1:15);
    tri = delaunay(x,y);
    z = peaks(15);
    tsh = trisurf(tri,x,y,z);
    T = imread('models/default-w720.jpg');
    %UV=()
[IO,A] = apply_texture_map(tsh,UV,T);