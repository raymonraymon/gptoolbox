    clc
    clear
    close all
    dbstop if error
    warning off all  
    
    u=[1 0.05 1;5 2 6];
    v=[1 1 98;8 7 4];
[w,a] = axisanglebetween(u,v);

%q = [cos(a) sin(a)*w];
q = axisangle2quat(w,2*a);

vv=quatmultiply(q,[[0;0] u]);
cross(v,vv(2:4),2) %suppose all zero
