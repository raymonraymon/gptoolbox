
clear
close all
clc
dbstop if error
%[V,F] = subdivided_sphere(2);
[V,F]=readOBJ('halfsphereNotclose.obj');
    
    [VV,TT,FF,TN] = cdt(V,F);
    
    [S,DEle,DV,DF] = murali_funkhouser(V,F);
    % visualize output
    
    %medit(DV,DEle,DF,'Data',S);
    
    % "Solid" tets
    CEle = DEle(S>0,:);
    [CV,I] = remove_unreferenced(DV,CEle);
    CEle = I(CEle);
    % Accordingly oriented boundary faces
    CF = boundary_faces(CEle);
    % Visualize solution
    
    %medit(CV,CEle,CF);