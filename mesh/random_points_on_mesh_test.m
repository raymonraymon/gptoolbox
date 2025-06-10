clc
clear
close all
dbstop if error

%%
%[V,F] = subdivided_sphere(3);
[V,F]=readOBJ('../models/faketooth/fakeTooth_11.obj');
n = 600;
for i=1:2
    subplot(1,2,i);
    drawMesh(V,F,'facecolor','y','edgecolor','none','facealpha','0.095');hold on;
    
    if i==1
        color = 'blue';
    else
        color = 'white';
    end
    [N,I,B,r] = random_points_on_mesh(V,F,n,'Color',color);
    title(color)
    plot3(N(:,1),N(:,2),N(:,3),'r.',...
                    'LineWidth',0.1,...
                    'MarkerSize',15.2,...
                    'MarkerEdgeColor','r',...
                    'MarkerFaceColor',[0.25,0.85,0.75]);
    [CE,PC] = crust(N);
    drawMesh(N,CE)
    writeOBJ([color,'Noise.obj'],N,[]);
    view(3)          
    axis equal
    axis off
    camlight
    lighting gouraud
    
end
