clc 
clear
close all
dbstop if error
[U,F]  = subdivided_sphere(2);
U = U*diag(ones(3,1))+ones(size(U));
[V,~] = subdivided_sphere(2);
drawMesh(U,F,'facecolor','g', 'edgecolor','k');
drawMesh(V,F);
[R,t] = fit_rigid(V,U);
    UU = bsxfun(@plus,U*R,t);