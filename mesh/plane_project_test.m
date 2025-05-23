clear
close all
clc
dbstop if error
%[V,F]=subdivided_sphere(2);
[V,F]=readOBJ('..\models\halfsphereNotclose.obj');
  LV = cotmatrix(V,F);
    [U,UF,I] = plane_project(V,F);
    drawMesh(U,UF);
    LU = cotmatrix(U,UF);
    ILUI = I*LU*I';
    max(max(abs(LV-ILUI)))