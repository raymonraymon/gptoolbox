    clc
    clear
    close all
    dbstop if error
    warning off all  
s=10;r=5;  

[V,F] = annulus(s,r);
 % Fit to half the unit square
    V = V/(2*max(max(V)-min(V))); 
    % Initialize as stretched object
    U = 1.5*V-V;
    Ud = zeros(size(V));
    t = tsurf(F,V+U);
    axis equal;
    axis manual;
    while true
      [U,Ud] = linear_elasticity(V,F,[],[],'U0',U,'Ud0',Ud);
      t.Vertices = V+U;
      drawnow;
    end