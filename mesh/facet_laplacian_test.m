    clc
    clear
    close all
    dbstop if error
    warning off all 


s=100;r=5;  

[V,F] = annulus(s,r);

% load some non-convex shape (V,F)
    [L,E] = facet_laplacian(V,F);
    % find boundary edges
    B = compute_boundary(F);
    % Construct mass matrix
    [M,mE] = crouzeix_raviart_massmatrix(V,F);
    % Be sure same edges are being used.
    assert(all(E(:)==mE(:)));
    % "Kill" boundary edges
    L(B,:) = 0;
    % Linear functions are now in the spectrum
    [~,~,U] = svd(full(L));
    tsurf(F,[V(:,1:2) U(:,end-1)])
  
    % mesh in (V,F)
    [Le] = facet_laplacian(V,F);
    [Lcr,E,EMAP] = crouzeix_raviart_cotmatrix(V,F);
    V2E = sparse(E(:),repmat(1:size(E,1),1,size(E,2))',1,size(V,1),size(E,1))';
    V2E = bsxfun(@rdivide,V2E,sum(V2E,2));
    LcrV2E = Lcr*V2E;
    max(max(abs(LcrV2E--2*Le)))