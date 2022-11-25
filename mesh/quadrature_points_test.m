clear;
clc;
close all
dbstop if error;
%%

[V,F]=subdivided_sphere(1);

%%
Q = quadrature_points(V,F,1);
    QQ = reshape(permute(Q,[1 3 2]),[],3);
    QQQ = permute(reshape(QQ,permute(size(Q),[1 3 2])),[1 3 2]);
    max(abs(Q-QQQ))
  