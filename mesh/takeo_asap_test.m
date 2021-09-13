%test_takeo_asap

clear
close all
clc
dbstop if error

%%
 %[x,y]= meshgrid(3:15,1:15);
[x,y,z] = peaks(15);
T = delaunay(x,y);
%trimesh(T,x,y,z);
%figure;
% TO = triangulation(T,x(:),y(:),z(:));
% trimesh(TO)

V=[reshape(x,numel(x),1),reshape(y,numel(y),1),reshape(z,numel(z),1)];
drawMesh(V,T);

v1 = V(:,1:2);f1=T;
b=[1,15];
bc =[-3 0;
     9 0];
%%
[U,XI,YI] = takeo_asap(v1,f1,b,bc);%takeo_arap
uplot = [U,V(:,3)];
patch('Faces',f1,'Vertices',uplot,'FaceColor','y','FaceAlpha',1.0);