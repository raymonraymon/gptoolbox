    clc
    clear
    close all
    dbstop if error
    warning off all  
    %%
    k =20;
    t = linspace(0,2*pi,k);
    r = 1;
    input = [r*sin(t);r*cos(t)];
    %%
    V= input';
    E = [1:k; [2:k,1]]';
    H=[];
    
    
    [TV,TF,TN] = triangle(V,E,H,'MaxArea',0.5, 'Quality',30, 'NoBoundarySteiners', 'NoEdgeSteiners');
    drawMesh(TV,TF);