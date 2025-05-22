clc;
clear;
close all
dbstop if error;
%%
% 
theta = [0:0.12:2*pi,0];r=3;
P1=[r*sin(theta);r*cos(theta)]';
distrub = 0.15*rand(size(P1,1),2);
distrub(end,:)=distrub(1,:);
P=P1+distrub;
plot(P(:,1),P(:,2));hold on;
offset = 0.3;

[SI,SO,EI,EO] = offset_curve(P, offset);

plot(SI(:,1),SI(:,2));
plot(SO(:,1),SO(:,2));
axis equal;