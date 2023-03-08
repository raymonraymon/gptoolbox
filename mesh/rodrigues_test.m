clc
clear
close all
dbstop if error    

%%
N=[0 0 1];
phi = pi/3;
[R,W] = rodrigues(N,phi);
Rf=full(R);
Wf=full(W);

%%
[V,F]= subdivided_sphere(1);
Z = V(:,3);%rand(size(V,1),1);
%%
% Given a scalar function Z on a mesh (V,F)
    
    G = grad(V,F);
    N = normalizerow(normals(V,F));
    X = reshape(G*Z,[],3);
    Y = reshape(rodrigues(N,pi/2)*G*Z,[],3);
    BC = barycenter(V,F);
    tsurf(F,V,'CData',Z,fphong,'EdgeColor','k','facealpha','0.25');
    hold on;
    quiver3(BC(:,1),BC(:,2),BC(:,3),N(:,1),N(:,2),N(:,3))
    view(3);
    axis equal
    axis off
    camlight
    lighting gouraud
    cameratoolbar
    set(gca, 'Position',[0 0 1 1]);
    quiver3(BC(:,1),BC(:,2),BC(:,3),X(:,1),X(:,2),X(:,3))    
    quiver3(BC(:,1),BC(:,2),BC(:,3),Y(:,1),Y(:,2),Y(:,3))
    
    hold off;
%myaa(2,'standard');
   