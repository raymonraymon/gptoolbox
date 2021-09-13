function s = path_to_robustcrust()
  % path_to_robustcrust Returns absolute, system-dependent path to path_to_robustcrust executable
  %
  % Outputs:
  %   s  path to path_to_robustcrust as string
  %  
  % See also: robustcrust

  if ispc
    warning([ ...
      'Dear Ladislav, is there a standard place to put executables on a pc?' ...
      'Could you put meshfix there and change this accordingly?' ...
      'Thanks, Alec']);
    s = 'D:/code/Surface-Reconstruction-Toolbox/bin/x64/Release/robustcrust.exe';
  elseif isunix || ismac
    % I guess this means linux
    [status, s] = system('which meshfix');
    s = strtrim(s);
    if isempty(s)
      guesses = { ...
        '/usr/local/bin/meshfix', ...
        '/opt/local/bin/meshfix', ...
        '/usr/local/igl/libigl/external/MeshFix/meshfix', ...
        '/usr/local/libigl/external/MeshFix/meshfix'};
    found = find(cellfun(@(guess) exist(guess,'file'),guesses),1,'first');
    if found
      s = ...
        guesses{find(cellfun(@(guess) exist(guess,'file'),guesses),1,'first')};
    end
      assert(~isempty(s),'Could not find meshfix');
    end
  end
end
