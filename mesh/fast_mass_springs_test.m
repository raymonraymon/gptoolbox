close all
clc
clear
dbstop if error

%%
V=[0 0 1;
    1 2 -1;
    0 0 3];
E=[1,2;
    2,3];

[V,F] = subdivided_sphere(1);E=edges(F);

%%
% for i = 1:size(E,1)
%     plot3(V(E(i,:),1),V(E(i,:),2),V(E(i,:),3),'*-');hold on;
% end
drawMesh(V,F,'facealpha',0.5);
%%
b = [1 13];
bc =V(b,:)+[0 0 0.1;    
    0 0 0.3];
EdgeLengths=0.85*ones(size(E,1),1);
[U,data] = fast_mass_springs(V,E,b,bc);%,'EdgeLengths',EdgeLengths);
%%
for i = 1:size(E,1)
    plot3(U(E(i,:),1),U(E(i,:),2),U(E(i,:),3),'>-');hold on;
end

        view(3);
        axis equal
        axis off
        camlight
        lighting gouraud
        set(gca, 'Position',[0 0 1 1]);