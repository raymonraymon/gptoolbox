clc 
clear
close all
dbstop if error
[V,F] = subdivided_sphere(1);
drawMesh(V,F);
A = adjacency_matrix(F);
    [~,P] = graphshortestpath(A,1);
    E = [P{end}(1:end-1);P{end}(2:end)]';
    [G,I] = cut_edges(F,E);
    W = V(I,:);
    tsurf(G,W+10*(massmatrix(W,G)\cotmatrix(W,G)*W))
    hold on;
    plot_edges(E,V,'g');
    hold off;
    view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);