clc
close all
clear
%%

P=[3 4 0;
    0.5 1 0];
S=[0 0 0];
D=[1,0,0];

[T,sqrD] = project_to_lines(P,S,D,'Segments',false);