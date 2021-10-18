    [Q,T] = forward_kinematics(C,BE,P,mpose);
    % stacked transposed 3x4 Affine matrices
    A = reshape(cat(2,permute(quat2mat(Q),[2 1 3]),permute(T,[2 3 1])),3,[])';
    n = size(V,1);
    M = reshape(bsxfun(@times,[V ones(n,1)],permute(W,[1 3 2])),n,[]);
    % Linear blend skinning:
    U = M*A;