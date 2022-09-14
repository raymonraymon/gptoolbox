%volume_triangleMesh_test
clc
close all
clear
dbstop if error

%%
% r =6;
% [V,F] = subdivided_sphere(1);
% V = r*V;
% [vol] = volume_triangleMesh(V,F);
% 
% exactVol = 4*pi/3*r^3;
% 
% error = abs(exactVol-vol)/exactVol

%%
    inputpath = '..\models\faketooth\';
    file = dir([inputpath, '*.obj']);
    nfile = length(file);
    vol = zeros(nfile,1);
    figure;
    plot(vol,'.');
    hold on;
	for i = 1:nfile
        [V,F] = readOBJ([inputpath,file(i).name]);
        v = volume_triangleMesh(V,F);
        new = erase(file(i).name,'_');
        text(i-1,v+20,new);
        vol(i) = v;
    end
    plot(vol,'-.ks',...
    'LineWidth',2,...
    'MarkerSize',4,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0.25,0.85,0.75]);
    
    