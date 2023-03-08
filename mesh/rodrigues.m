function [R,W] = rodrigues(N,phi)
  % RODRIGUES Construct the rotation matrix for rotating vectors around each
  % given vector.
  %
  % Inputs:
  %   N  #N by 3 list of 3D vectors
  %   phi  angle to rotate by.
  % Outputs:
  %   R  3#N by 3#N "rotation" matrix
  %   W  3#N by 3#N cross product matrix
  % 
  % Example:
  %   % Given a scalar function Z on a mesh (V,F)
  %   G = grad(V,F);
  %   N = normalizerow(normals(V,F));
  %   X = reshape(G*Z,[],3);
  %   Y = reshape(rodrigues(N,pi/2)*G*Z,[],3);
  %   BC = barycenter(V,F);
  %   tsurf(F,V,'CData',Z,fphong,'EdgeColor','none');
  %   hold on;
  %   quiver3(BC(:,1),BC(:,2),BC(:,3),X(:,1),X(:,2),X(:,3))
  %   quiver3(BC(:,1),BC(:,2),BC(:,3),Y(:,1),Y(:,2),Y(:,3))
  %   hold off;
  %   

  m = size(N,1);
  % Either uniform angle or per-vector
  if numel(phi)>1
    assert(numel(phi) == m);
    phi = diag(sparse(phi));
  end
  % https://math.stackexchange.com/a/142831
  %
  i = zeros(3*m,1);
  for ii = 1:m
      i((ii-1)*6+1:ii*6) = [1 2 0 2 0 1]*ii+repmat(ii,1,6);
  end
  j = zeros(3*m,1);
  for jj = 1:m
      j((jj-1)*6+1:jj*6) = [0 0 1 1 2 2]*jj+repmat(jj,1,6);
  end
  W = sparse( ...
    i, ...
    j, ...
    [N(:,3) -N(:,2) -N(:,3) N(:,1) N(:,2) -N(:,1)], ...
    3*m,3*m);
   NNT = zeros(3*m,3*m);
   for n = 0:m-1
        NNT(3*n+1:3*(n+1),3*n+1:3*(n+1)) = N(n+1,:)'*N(n+1,:);
   end
  if isempty(phi)
    R = [];
  else
    R = cos(phi)*speye(3*m,3*m) + sin(phi)*W + (2*sin(phi/2)^2) * sparse(NNT);
  end
end
