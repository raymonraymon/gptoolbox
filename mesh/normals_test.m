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

[V,F] = subdivided_sphere(2);
drawMesh(V,F);
[ Nunnormal ] = normals(V,F,'UseSVD','true');
[ N ] = normalizerow( Nunnormal);
facecenter = 1/3*(V(F(:,1),:)+V(F(:,2),:)+V(F(:,3),:));

quiver3(facecenter(:,1),facecenter(:,2),facecenter(:,3),N(:,1),N(:,2),N(:,3),0.5)

 view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);

