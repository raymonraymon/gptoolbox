function [V,F] = robustcrust(V) 
  % Call robustcrust on a points cloud
  %
  % [W,G] = robustcrust(V) 
  %

  %
  prefix = tempname;
    
  cgo_filename = [prefix '.cgo'];
  writeCGO(cgo_filename,V);
  obj_filename = [prefix '_fixed.obj'];

  flags1 = '-in';
  flags2 = '-out';
  command = [path_to_robustcrust ' ' flags1 ' ' cgo_filename ' ' flags2 ' ' obj_filename];
  status = system(command);
  if status ~= 0
    fprintf(command);
    %error(result);
  end
  [V,F] = readOBJ(obj_filename);
  delete(cgo_filename);
  delete(obj_filename);
end
