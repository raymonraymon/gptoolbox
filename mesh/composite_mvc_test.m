    [V,F,VT,FT] = readOBJ('../models/bunny.obj');
    [UE,UT,OT] = straighten_seams(V,F,VT,FT,'Tol',inf);
    [P0,J,I] = remove_unreferenced(VT,OT);
    P1 = UT(I,:);
    E = J(OT);
    WCMV = composite_mvc(VT,P0,E,P1);
    WCMV(I,:) = P1;