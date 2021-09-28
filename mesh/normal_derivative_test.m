    clc
    clear
    close all
    dbstop if error
    warning off all  
[V,F]=subdivided_sphere(2);
[DD,E,N] = normal_derivative(V,F);
    % normalize and Divide by lengths again to account for integral averaging
    UN = bsxfun(@rdivide,N,normrow(N).^2);
    [~,C] = on_boundary(F);
    EBC = 0.5*(V(E(:,1),:)+V(E(:,2),:));
    % Treat X-coordinate as scalar field
    X = V(:,1);
    DDX = bsxfun(@times,(DD*X),UN);
    tsurf(F,V,'CData',X,fphong,'EdgeColor','none');
    colormap(jet(20))
    axis equal
    view(2)
    hold on;
    quiver(EBC(C,1),EBC(C,2),DDX(C,1),DDX(C,2),0.2, ...
      'k','LineWidth',2)
    hold off;
    title('Integral average normal derivative','FontSize',20);