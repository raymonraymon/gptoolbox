clc
    clear
    close all
    dbstop if error
    warning off all    
    
    [V,F]=subdivided_sphere(1);
    F(1:5,:)=[];
    [SV,SF,SVJ] = clean_mesh(V,F);
   [DV,DT,DF,DN] = cdt(SV,SF);
   % remap final vertices and final tets to work with original faces
   IM = [SVJ(:)' max(SVJ)+1:size(DV,1)];
   RIM = 1:size(DV,1);
   RIM(IM) = 1:numel(IM);
   % Extension of original vertices
   VDV = DV(IM,:);
   % final tets and faces defined over extension of original vertices
   VDF = RIM(DF);
   VDT = RIM(DT);
  %
  %  % Remove only degeneracies and duplicates
  %  [SV,SF] = clean_mesh(V,F,'MinDist',0,'MinArea',0,'MinAngle',0, ...
  %    'SelfIntersections','ignore','SmallTriangles','remove');