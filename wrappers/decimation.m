function [W,G] = decimation(V,F,percent) 
  % Call pmp library's decimation on a mesh
  %
  % [W,G] = decimation(V,F) 
  %
  % Inputs:
  %   V  #V by 3 list of mesh vertex positions
  %   F  #F by 3 list of triangle indices
  % Outputs:
  %   W  #W by 3 list of output mesh vertex positions
  %   G  #G by 3 list of output triangle indices
  %
  if nargin < 3
      percentage = '0.1';
  elseif percent > 1.0
    W=V;
    G=F;
    return;
  else          
      percentage = num2str(percent);
  end  
  prefix = tempname;
  obj_filename = [prefix '.obj'];
  obj_filename_decimated = [prefix '_fixed.obj'];
  writeOBJ(obj_filename,V,F);

  command = [path_to_decimation ' ' percentage ' ' obj_filename ' ' obj_filename_decimated];
  [status, result] = system(command);
  if status ~= 0
    fprintf(command);
    error(result);
  end
  [W,G] = readOBJ(obj_filename_decimated);

  delete(obj_filename);
  delete(obj_filename_decimated);
end
