    clc
    clear
    close all
    dbstop if error
    warning off all 
[V,F]= subdivided_sphere(1); 
C = cotangent(V,F);