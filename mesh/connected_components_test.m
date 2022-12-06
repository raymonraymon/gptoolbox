close all
clc
clear

%[V,F]=subdivided_sphere(2);
[V,F]=readOBJ('models/ÁõÃ÷³©_117544_uppercasting.obj');
  trisurf(F,V(:,1),V(:,2),V(:,3), ...
    connected_components([F;repmat(size(V,1),1,3)]));
        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);