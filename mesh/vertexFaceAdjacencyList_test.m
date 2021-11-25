%vertexFaceAdjacencyList

clear
close all
clc
dbstop if error

[V,F] = subdivided_sphere(1);
adj = vertexFaceAdjacencyList(F);