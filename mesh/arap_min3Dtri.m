function [U] = arap_min3Dtri(V,F,b,bc,varargin)
% ARAP Solve for the as-rigid-as-possible deformation according to various
  % manifestations including:
  %   (1) "As-rigid-as-possible Surface Modeling" by [Sorkine and Alexa 2007]
  %   (2) "A local-global approach to mesh parameterization" by [Liu et al.
  %     2010] or "A simple geometric model for elastic deformation" by [Chao et
  %     al.  2010]
  %   (3) Adapted version of "As-rigid-as-possible Surface Modeling" by
  %     [Sorkine and Alexa 2007] presented in section 4.2 of or "A simple
  %     geometric model for elastic deformation" by [Chao et al.  2010]
  %
  % U = arap(V,F,b,bc) given a rest mesh (V,F) and list of constraint vertex
  % indices (b) and their new postions (bc) solve for pose mesh positions (U),
  % using default choice for 'Energy'
  %
  % U = arap(V,F,b,bc)
  %
  % Inputs:
  %   V  #V by dim list of rest domain positions
  %   F  #F by {3|4} list of {triangle|tetrahedra} indices into V
  %   b  #b list of indices of constraint (boundary) vertices
  %   bc  #b by dim list of constraint positions for b
  
  % Outputs:
  %   U  #V by dim list of new positions
  

  % number of vertices
  n = size(V,1);
  assert(isempty(b) || max(b) <= n,'b should be in bounds [1,size(V,1)]');
  assert(isempty(b) || min(b) >= 1,'b should be in bounds [1,size(V,1)]');

  indices = 1:n;
  max_iterations = 100;
  tol = 0.001;
  interior = indices(~ismember(indices,b));
  U = [];

 


  % remove rigid transformation invariance


  debug = true;
  data = [];
  Aeq = [];
  Beq = [];

  weight = [];


    energy = 'spokes-and-rims';
    ref_V = V;
    ref_F = F;
    dim = size(ref_V,2);

  assert(dim == size(bc,2));
  assert(size(Aeq,1) == size(Beq,1));
  assert((size(Aeq,2) == 0) || (size(Aeq,2) == dim*size(V,1)));

  if isempty(U)
    if(dim == 2) 
      U = laplacian_mesh_editing(V,F,b,bc);
    else
      U = V;
    end
    U = U(:,1:dim);
  end
  assert(n == size(U,1));
  assert(dim == size(U,2));


    dyn_alpha = 1;


    data.L = cotmatrix(ref_V,ref_F);

  

  all = [interior(:);b(:)]';


  
   data.ae = avgedge(V,F);


   data.CSM = covariance_scatter_matrix(ref_V,ref_F,'Energy',energy);
  
  % build covariance scatter matrix used to build covariance matrices we'll
  % later fit rotations to

    %assert(size(ref_V,2) == dim);
    data.CSM = covariance_scatter_matrix(ref_V,ref_F,'Energy',energy);

    

  

  % precompute rhs premultiplier

    [~,data.K] = arap_rhs(ref_V,ref_F,[],'Energy',energy,'Weight',weight);


  % initialize rotations with identies (not necessary)
  R = repmat(eye(dim,dim),[1 1 size(data.CSM,1)/dim]);

  iteration = 1;
  U_prev = V;
  data.energy = inf;
  while true

    if iteration > max_iterations
      if debug
        fprintf('arap: Iter (%d) > max_iterations (%d)\n',iteration,max_iterations);
      end
      break;
    end

    if iteration > 1
      change = max(abs(U(:)-U_prev(:)));
      if debug
        fprintf('arap: iter: %d, change: %g, energy: %g\n', ...
          iteration,change/data.ae,data.energy);
      end
      if change/data.ae <tol
        if debug
          fprintf('arap: change (%g) < tol*ae (%g * %g)\n',change,tol,data.ae);
        end
        break;
      end
    end

    U_prev = U;

    % energy after last global step
    %U(b,:) = bc;
    
    %E = arap_energy(V,F,U,R);
    %[1 E]

    % compute covariance matrix elements
    S = zeros(size(data.CSM,1),dim);
    S(:,1:dim) = data.CSM*repmat(U,dim,1);
    % dim by dim by n list of covariance matrices
    SS = permute(reshape(S,[size(data.CSM,1)/dim dim dim]),[2 3 1]);
    % fit rotations to each deformed vertex
    R = fit_rotations(SS,'SinglePrecision',false);

    % energy after last local step
    U(b,:) = bc;
    %E = arap_energy(V,F,U,R);
    %[2 E]


    % This is still the SLOW way of building the right hand side, the entire
    % step of building the right hand side should collapse into a
    % #handles*dim*dim+1 by #groups matrix times the rotations at for group
    


    U(b,:) = bc;

    %B = arap_rhs(V,F,R);
    Rcol = reshape(permute(R,[3 1 2]),size(data.K,2),1);
    Bcol = data.K * Rcol;
    B = reshape(Bcol,[size(Bcol,1)/dim dim]);

    zQ = -0.5*dyn_alpha*data.L;
    zL = -dyn_alpha*B;
    % RemoveRigid requires to solve each indepently


        cellfun(@(v) assignin('base',v,evalin('caller',v)),{'zQ','zL'});
        [U,data.preF] = min_quad_with_fixed(zQ,zL,b,bc);
      

    energy_prev = data.energy;
    data.energy = trace(U'*(zQ)*U+U'*(zL))+trace(V'*(0.5*dyn_alpha*data.L*V));
    if data.energy > energy_prev
      if debug
        fprintf('arap: energy (%g) increasing (over %g) (iter %d)\n', ...
          data.energy,energy_prev,iteration);
      end
      break;
    end

    %U(interior,:) = -L(interior,interior) \ (B(interior,:) + L(interior,b)*bc);
    %U(interior,:) = -L(interior,all)*L(all,interior) \ (L(interior,all)*B(all,:) + L(interior,all)*L(all,b)*bc);
    %U(interior,:) = luQ*(luU\(luL\(luP*(luR\(B(interior,:)+L(interior,b)*bc)))));
    %U(interior,:)=cholL\((B(interior,:)+L(interior,b)*bc)'/cholL)';
    iteration = iteration + 1;
  end
  U = U(:,1:dim);
end
