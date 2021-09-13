    clc
    clear
    close all
    dbstop if error
    warning off all  
    
[V,F]=subdivided_sphere(1);
[U,G]=subdivided_sphere(1);
U=U+0.2*ones(size(U));
[W,H,J] = mesh_boolean_winding_number(V,F,U,G,'union');

drawMesh(W,H);

%not passed