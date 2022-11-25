close all
clc
clear
dbstop if error;
%%

P=rand(10,4);
C=[1 4 6 9];
[pe,p] = plot_spline(P,C);

%error