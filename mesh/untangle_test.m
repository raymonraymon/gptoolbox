close all;
clc;
clear;
dbstop if error;
%%
[V,F] = subdivided_sphere(2);
V = V+0.1*rand(size(V));
drawMesh(V,F,'facealpha',0.5);
[VV,Uforward,Ubackward] = untangle(V,F,'ExpansionEnergy','arap');

drawMesh(VV,F,'facealpha',0.15,'facecolor',g);
