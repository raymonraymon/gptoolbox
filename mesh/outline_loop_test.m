clc
clear
close all
%[V,F] = subdivided_sphere(2);
[V,F]=readOBJ('halfsphereNotclose.obj');
O = outline(F);
   loops = {};
   while ~isempty(O)
     loops{end+1} = outline_loop(O);
     O = O(~all(ismember(O,loops{end}),2),:);
   end