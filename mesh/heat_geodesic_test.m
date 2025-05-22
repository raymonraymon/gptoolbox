


   
    clc
    clear
    close all
    dbstop if error
    warning off all  
    n=10;
    a=5;
    
%[V,F]=subdivided_sphere(1);
[V,F]=readOBJ('D:\code\mls3d\input\210475_lowertooth3.obj');
gamma = [2020 2192 1851 2024 1854]+1;

plot3(V(gamma,1),V(gamma,2),V(gamma,3),'--yh','LineWidth',2,...
                       'MarkerEdgeColor','y',...
                       'MarkerFaceColor','y',...
                       'MarkerSize',10);hold on;

if 0
    c = 10;
    t = c * mean(doublearea(V, F))/2;
    D = heat_geodesic(V,F,gamma,t,'BoundaryConditions','neumann');
else
    D = geodesics_in_heat(V,F,gamma);
end

x = 8;
options.method = 'continuous';
%[D,S,Q] = perform_fast_marching_mesh(V,F, gamma);
[path,vlist,plist] = compute_geodesic_mesh(D, V,F, x, options);
path = path';
plot3(path(:,1),path(:,2),path(:,3),'--gh','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10);

drawMesh(V,F,'FaceVertexCData',D,'facecolor','interp', 'edgecolor','none');
        view(3);
        axis equal
        axis off
        %camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
        add_lights()
        
  %iso = linspace(min(D),max(D),20);
  iso = max(D)/4;
  [LS,LD] = isolines(V,F,D,iso);
  
  colormap(jet(numel(iso)-1));
  tsurf(F,V,'CData',D,fphong);
  hold on;
  plot3([LS(:,1) LD(:,1)]',[LS(:,2) LD(:,2)]',[LS(:,3) LD(:,3)]', ...
    'Color','k','LineWidth',0.10);


plot3(LS(:,1),LS(:,2),LS(:,3),'gh','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','r',...
                       'MarkerSize',10);
plot3(LD(:,1),LD(:,2),LD(:,3),'gh','LineWidth',2,...
                       'MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10);
  hold off;