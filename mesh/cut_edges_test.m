clc 
clear
close all
dbstop if error
%%
[V,F] = subdivided_sphere(1,'Radius',0.5,'SubdivisionMethod','sqrt3');
writeOBJ('../models/sphere1.obj',V,F);

%%
%[V,F] = readOBJ('models/sphere1.obj');
drawMesh(V,F,'facealpha',0.3);
allE = edges(F);
line = [12 13 14 15 16]+1;
E=[line(1:end);line([2:end,1])]';
plot_edges(V,E,'g');
[G,I] = cut_edges(F,E);
        
    W = V(I,:); 

    
trisurf(G,W(:,1),W(:,2),W(:,3), ...
    connected_components([G;repmat(size(W,1),1,3)]));
        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
        

%%
figure;
A = adjacency_matrix(F);
    [~,P] = graphshortestpath(A,1);
    E = [P{end}(1:end-1);P{end}(2:end)]';
    [G,I] = cut_edges(F,E);
    W = V(I,:);
    tsurf(G,W+10*(massmatrix(W,G)\cotmatrix(W,G)*W))
    hold on;
    plot_edges(V,E,'g');
    hold off;
    view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);