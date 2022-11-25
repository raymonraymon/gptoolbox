clc
clear
close all
dbstop if error    
[V,F]= subdivided_sphere(2);
Z = V(:,1);%rand(size(V,1),1);
%%
% Given a scalar function Z on a mesh (V,F)
    
    G = grad(V,F);
    N = normalizerow(normals(V,F));
    X = reshape(G*Z,[],3);
    Y = reshape(rodrigues(N,pi/2)*G*Z,[],3);
    BC = barycenter(V,F);
    tsurf(F,V,'CData',Z,fphong,'EdgeColor','none');
    hold on;
    quiver3(BC(:,1),BC(:,2),BC(:,3),X(:,1),X(:,2),X(:,3))
    quiver3(BC(:,1),BC(:,2),BC(:,3),Y(:,1),Y(:,2),Y(:,3))
    hold off;
myaa(2,'standard');
%    view(3);
%    axis equal
%    axis off
%    camlight
%    lighting gouraud
%    cameratoolbar
%    set(gca, 'Position',[0 0 1 1]);