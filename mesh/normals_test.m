%     timeit(@() normalizerow(normals(UV,UF)))
%     % faster unit normals
%     cross2 = @(a,b,c) ...
%       [a(:,2).*b(:,3)-a(:,3).*b(:,2), ...
%        a(:,3).*b(:,1)-a(:,1).*b(:,3), ...
%        a(:,1).*b(:,2)-a(:,2).*b(:,1)];
%     nrmlev = @(p1,p2,p3) cross2(p2-p1,p3-p1);
%     unrml = @(V,F) normalizerow(nrmlev(V(F(:,1),:),V(F(:,2),:),V(F(:,3),:)));
%     timeit(@() unrml(UV,UF))

close all
clc
clear
%%
% [V,F] = subdivided_sphere(2);
% drawMesh(V,F);
% [ Nunnormal ] = normals(V,F,'UseSVD','true');
% [ N ] = normalizerow( Nunnormal);
% facecenter = 1/3*(V(F(:,1),:)+V(F(:,2),:)+V(F(:,3),:));
% 
% quiver3(facecenter(:,1),facecenter(:,2),facecenter(:,3),N(:,1),N(:,2),N(:,3),0.5)
% 
%  view(3);
%         axis equal
%         axis off
%         camlight
%         lighting gouraud
%         set(gca, 'Position',[0 0 1 1]);
%%
[V,T,F] = regular_tetrahedral_mesh(5,5,5);
    temp = T(:,1);
    T(:,1) = T(:,2);
    T(:,2) = temp;

[F,J,K] = boundary_faces(T);

%drawMesh(V,F,'FaceAlpha',0.25);
[ Nunnormal ] = normals(V,F,'UseSVD','true');
[ N ] = normalizerow( Nunnormal);
facecenter = 1/3*(V(F(:,1),:)+V(F(:,2),:)+V(F(:,3),:));

quiver3(facecenter(:,1),facecenter(:,2),facecenter(:,3),N(:,1),N(:,2),N(:,3),0.5)

%%
demoldDir = -[0 1 0];
sigma = 0.5;
for i = 1:size(N,1)
    if dot(demoldDir,N(i,:)) < sigma
    theta = acos(max(dot(demoldDir,N(i,:))-sigma,-1))-pi/2;
    axTemp = cross(demoldDir,N(i,:));
    q = axisangle2quat(axTemp,theta);
    vi = [V(F(i,1),:);V(F(i,2),:);V(F(i,3),:)];
    Vplot = vi*quat2mat(q);
    drawMesh(Vplot,[1 2 3],'facecolor','y','edgecolor','r');
    end
end
                
%%
 view(3);
        axis equal
        xlabel('x');
        ylabel('y');
        zlabel('z');
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
