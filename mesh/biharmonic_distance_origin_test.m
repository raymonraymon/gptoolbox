%biharmonic_distance_origin
clear
close all
clc
dbstop if error
%https://gfx.cs.princeton.edu/pubs/Lipman_2010_BD/index.php
%%
[V,F] = subdivided_sphere(2);
writeOFF('sphere.off', V,F);

dists = biharmonic_distance_origin('sphere.off', 'dist_file.txt');