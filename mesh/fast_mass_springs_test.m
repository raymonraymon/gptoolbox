close all
clc
clear
dbstop if error

%%
V=[0 0 1;
    0 0 0;
    0 0 3];
E=[1,2;
    2,3];
b = [1 3];
bc =[0 0 1;    
    0 0 3];
EdgeLengths=[0.4;0.1];
[U,data] = fast_mass_springs(V,E,b,bc,'EdgeLengths',EdgeLengths);