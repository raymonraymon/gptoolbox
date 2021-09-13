clc;
close all;
clear ;
dbstop if error ;
warning('off');

[V,T,F] = regular_tetrahedral_mesh(3,3,3);
tetramesh(T,V); %also try tetramesh(T,V,'FaceAlpha',0);
trisurf(F,V(:,1),V(:,2),V(:,3));