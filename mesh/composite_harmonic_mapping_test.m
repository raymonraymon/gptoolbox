clc
clear
close all
dbstop if error
%%
[V,F,VT,FT] = readOBJ('~/Dropbox/models/textured-models-from-daniele/animal/animal.obj');
[UE,UT,OT] = straighten_seams(V,F,VT,FT,'Tol',inf);
b = unique(OT);
bc = UT(b,:);
WCH = composite_harmonic_mapping(VT,FT,b,bc);