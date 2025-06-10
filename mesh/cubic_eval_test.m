%cubic_eval_test

clc
clear
close all
dbstop if error
%%
C =rand(4,2);
V=sort(C,1);
t = [0:0.020:1];
P = cubic_eval(V,t);

plot(P(:,1),P(:,2));