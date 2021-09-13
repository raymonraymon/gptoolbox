


   
    clc
    clear
    close all
    dbstop if error
    warning off all  
    n=10;
    a=5;
    
[V,F]=subdivided_sphere(2);
[V,F]=readOBJ('halfsphereNotclose.obj');
gamma = [38];

if 1
    c = 10;
    t = c * mean(doublearea(V, F))/2;
    D = heat_geodesic(V,F,gamma,t,'BoundaryConditions','natural');
else
    D = geodesics_in_heat(V,F,gamma);
end


drawMesh(V,F,'FaceVertexCData',D,'facecolor','interp', 'edgecolor','y');
        view(3);
        axis equal
        axis off
        %camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);
        add_lights()
        
        iso = linspace(min(D),max(D),20);
  [LS,LD] = isolines(V,F,D,iso);
  
  colormap(jet(numel(iso)-1));
  tsurf(F,V,'CData',D,fphong);
  hold on;
  plot3([LS(:,1) LD(:,1)]',[LS(:,2) LD(:,2)]',[LS(:,3) LD(:,3)]', ...
    'Color','k','LineWidth',10);
  hold off;