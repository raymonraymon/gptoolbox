%test_arap

clear
close all
clc
dbstop if error

% %%
% %dim = 2
%   xRes = 32;
%   yRes = 32;
%   % here we tell the function that we want a disc topology
%   wrap = 0;
%   % Output:
%   %  F: list of triangles, each row is 3 indices to vertex list, thus #triangles x 3 array
%   %  V: list of vertex positions #vertices x 2 array, (2D so far)
%   %  res: legacy value
%   %  edge_norms: list of norms for each edge, ordered like F for edges opposite
%   %              vertex index, thus #triangles x 3 array
%   [V,F,res,edge_norms] = create_regular_grid(xRes,yRes,wrap,wrap);
%   Vplot = [V(:,1), V(:,2), zeros(size(V,1),1)];
% tsurf(F,Vplot, ...
%       'FaceColor','y', ...
%       'FaceLighting','phong', ...
%       'EdgeColor',[0.2 0.2 0.2]);
%   hold on;
% b=[1,500];
% bc =V(b,:)+[0 0.01 ;
%     0.22 0 ];
% %%
% [U,data,SS,R] = arap(V,F,b,bc);
% Uplot = [U(:,1), U(:,2), zeros(size(U,1),1)];
% tsurf(F,Uplot,'FaceAlpha',0.25);


%%
%dim = 3
[V,F]=subdivided_sphere(2);
figure;
drawMesh(V,F,'FaceAlpha',.5);
b=[1,80];
bc =V(b,:)+[1 0 0;
    0 0 1];
%%
[U,data,SS,R] = arap(V,F,b,bc);%,'Flat',true,'Energy','elements'

drawMesh(U,F);
view(3)
%zoom out
%zoom(1.5)
title('arap solution');
axis equal; 
axis vis3d;

%%
if 1
[V,T] = readTET('..\models\bunny.TET');
    V=V(:,1:3);
    T=T(:,1:4);
else
    [V,T,F] = regular_tetrahedral_mesh(5,5,5);
end

[F,J,K] = boundary_faces(T);
figure;
drawMesh(V,F,'FaceAlpha',0.5);

b=[10,80];
bc =V(b,:)+[0.01 0 0.04;0.02 0 0];
[U,data,SS,R] = arap(V,T,b,bc);

drawMesh(U,F,'FaceColor',[0.8 0.18 0.8]);
view(3)
%zoom out
%zoom(1.5)
title('arap solution');
axis equal; 
axis vis3d;


