close all
clc
clear

%[V,F]=subdivided_sphere(2);
[V,F]=readOBJ('ÁõÃ÷³©_117544_uppercasting.obj');
A = adjacency_dihedral_angle_matrix(V,F);
    % unsigned dihedral angles
    UA = pi*(A~=0)-abs(pi*(A~=0)-A);
  
    A = adjacency_dihedral_angle_matrix(V,F);
    % Adjacency matrix of nearly coplanar neighbors
    UA = pi*(A~=0)-abs(pi*(A~=0)-A);
    AF = UA>=(pi-1e-5);
    % get connected components
    C = connected_components(F);
    % plot with unique colors for each coplanar patch
    set(tsurf(F,V),'CData',C);
    CM = jet(numel(unique(C)));
    colormap(CM(randperm(end),:));
    view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);