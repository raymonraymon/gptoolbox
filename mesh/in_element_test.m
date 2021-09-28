close all
clc
clear
[V,F] = subdivided_sphere(3);
P = bsxfun(@plus,min(V),bsxfun(@times,rand(),max(V)-min(V)));
    [I,B1,B2,B3] = in_element(V,F,P);
    % Only keep first
    [mI,J] = max(I,[],2);
    I = sparse(1:size(I,1),J,mI,size(I,1),size(I,2));
    % Mask barycentric coordinates
    B1 = B1.*I;
    B2 = B2.*I;
    B3 = B3.*I;
    Q = B1*V(F(:,1),:) + B2*V(F(:,2),:) + B3*V(F(:,3),:);
    Q = Q(any(I,2),:);
    tsurf(F,V);
    hold on;
    plot(Q(:,1),Q(:,2),'or','LineWidth',6);
    plot(P(:,1),P(:,2),'ob','LineWidth',2);
    hold off;
    view(3);
    axis equal
    axis off
    camlight
    lighting gouraud
    set(gca, 'Position',[0 0 1 1]);