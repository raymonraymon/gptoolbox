%test_arap

clear
close all
clc
dbstop if error

% %%
% [V,F]=subdivided_sphere(2);
% drawMesh(V,F,'FaceAlpha',.5);
% b=[1,80];
% bc =[0 0 0;
%     2 0 0];
% %%
% [U,data,SS,R] = arap(V,F,b,bc);
% 
% drawMesh(U,F);
% view(3)
% %zoom out
% %zoom(1.5)
% title('arap solution');
% axis equal; 
% axis vis3d;

%%
[V,T] = readTET('..\models\bunny.TET');
    V=V(:,1:3);
    T=T(:,1:4);
[F,J,K] = boundary_faces(T);
drawMesh(V,F,'FaceAlpha',0.25);

b=[10,80];
bc =V(b,:)+[0.001 0 0.0004;0.0002 0 0];
[U,data,SS,R] = arap(V,T,b,bc);
drawMesh(U,F,'FaceColor',[0.8 0.18 0.8]);
view(3)
%zoom out
%zoom(1.5)
title('arap solution');
axis equal; 
axis vis3d;


