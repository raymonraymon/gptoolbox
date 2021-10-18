    
        clc
    clear
    close all
    dbstop if error
    warning off all 
    [V,F] = subdivided_sphere(1);
[N,E] = gauss_map(V,F);
    subplot(1,2,1);
    tsurf(F,V,'FaceVertexCData',0.5*N+0.5)
    axis equal;
    l = sqrt(sum((N(E(:,1),:) - N(E(:,2),:)).^2,2));
    E = E(l>0,:);
    [N,I] = remove_unreferenced(N,E);
    E = I(E);
    [N,E] = spherical_subdivision(N,E,'MaxIter',5,'MinLength',0.1);
    subplot(1,2,2);
    tsurf([E E(:,1)],N, ...
      'FaceVertexCData',0.5*N+0.5,'EdgeColor','interp','LineWidth',2);
    axis equal;
  
