[V,F]=subdivided_sphere(1);    
H = arap_hessian(V,F);
    M = repdiag(massmatrix(V,F),3);
    [~,N,Y] = exterior_skinning_modes(V,D,H,M,20);