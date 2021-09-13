function writeCGO(filename, V)
  % WRITEOBJ writes an CGO file with vertex/face information
  %
  % writeCGO(filename,V)
  %
  % Input:
  %  filename  path to .cgo file
  %  V  #V by 3 list of vertices
  
  %

%disp(['writing: ',filename]);
f = fopen( filename, 'w' );

if exist('comment','var') && ~isempty(comment)
  fprintf(f,'# %s\n',comment);
end

fprintf(f,'%d\n',size(V,1));

if size(V,2) == 2
  warning('Appending 0s as z-coordinate');
  V(:,end+1:3) = 0;
else
  %assert(size(V,2) == 3);
end
fprintf( f, [repmat(' %0.17g',1,size(V,2)) '\n'], V');




fclose(f);
