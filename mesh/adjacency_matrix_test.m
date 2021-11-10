clc;
close all;
clear ;
dbstop if error ;
warning('off');
[V,F]=subdivided_sphere(1);
A = adjacency_matrix(F);
L = A - diag(sparse(sum(A,2)));
