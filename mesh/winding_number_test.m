clc
close all
clear
[V,F]=subdivided_sphere(1);
O = [10,0,0];
[W] = winding_number(V,F,O);