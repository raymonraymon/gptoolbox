clc 
clear
close all
dbstop if error
[V,F] = subdivided_sphere(1);
% compute covariance matrices of a mesh
   n = size(V,1);
   dim = size(V,2);
   CSM = covariance_scatter_matrix(V,F,'Energy','spokes');
   S = CSM*repmat(U,dim,1);
   % dim by dim by n list of covariance matrices
   S = permute(reshape(S,[n dim dim]),[2 3 1]);