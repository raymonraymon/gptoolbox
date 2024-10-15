%test_arap

clear
close all
clc
dbstop if error

%%
if 1
%dim = 2
  xRes = 5;
  yRes = 5;
  % here we tell the function that we want a disc topology
  wrap = 0;
  % Output:
  %  F: list of triangles, each row is 3 indices to vertex list, thus #triangles x 3 array
  %  V: list of vertex positions #vertices x 2 array, (2D so far)
  %  res: legacy value
  %  edge_norms: list of norms for each edge, ordered like F for edges opposite
  %              vertex index, thus #triangles x 3 array
  [V,F,res,edge_norms] = create_regular_grid(xRes,yRes,wrap,wrap);
  Vplot = [V(:,1), V(:,2), zeros(size(V,1),1)];
tsurf(F,Vplot, ...
      'FaceColor','y', ...
      'FaceLighting','phong', ...
      'EdgeColor',[0.2 0.2 0.2]);
  hold on;
b=[1,20];
bc =V(b,:)+[0 0.01 ;
    0.22 0 ];
%%

U0 = laplacian_mesh_editing(V,F,b,bc);
U0plot = [U0(:,1), U0(:,2), zeros(size(U0,1),1)];
tsurf(F,U0plot,'FaceAlpha',0.25);

[U,data,SS,R] = arap(V,F,b,bc,'Dynamic',1);
Uplot = [U(:,1), U(:,2), zeros(size(U,1),1)];
tsurf(F,Uplot,'FaceAlpha',0.25);
end

%%
%dim = 3
[V,F]=subdivided_sphere(2);
figure;
drawMesh(V,F,'FaceAlpha',.5);
b=[1,80];
bc =V(b,:)+[2 0 0;
    0 0 2];
%%
[U] = arap_min3Dtri(V,F,b,bc);

drawMesh(U,F);
view(3)
%zoom out
%zoom(1.5)
title('arap solution');
axis equal; 
axis vis3d;


%%
if 0
[V,T] = readTET('..\models\bunny.TET');
    V=V(:,1:3);
    T=T(:,1:4);
else
    [V,T,~] = regular_tetrahedral_mesh(5,5,5);
    temp = T(:,1);
    T(:,1) = T(:,2);
    T(:,2) = temp;
end

v1 = sum(volume(V,T))
[F,J,K] = boundary_faces(T);
figure;
drawMesh(V,F,'FaceAlpha',0.5);


b=63;
bc =V(b,:)+[0.0 1 0.00];
[U,data,SS,R] = arap(V,T,b,bc);
v2 = sum(volume(U,T))

drawMesh(U,F,'FaceColor',[0.8 0.18 0.8]);
[RV,IM,J,IMF] = remove_unreferenced(U,F);
% temp = IMF(:,1);
% IMF(:,1) = IMF(:,2);
% IMF(:,2) = temp;
% 
% temp = F(:,1);
% F(:,1) = F(:,2);
% F(:,2) = temp;
writeOBJ('../models/arapinput.obj',V,F);
writeOBJ('../models/arapresult.obj',RV,IMF);
view(3)
%zoom out
%zoom(1.5)
title('arap solution');
axis equal; 
axis vis3d;

