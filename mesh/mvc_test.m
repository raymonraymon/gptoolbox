    [V,F,VT,FT] = readOBJ('../models/bunny.obj');
    [UE,UT,OT] = straighten_seams(V,F,VT,FT,'Tol',inf);
    [P0,J,I] = remove_unreferenced(VT,OT);
    P1 = UT(I,:);
    E = J(OT);
    MV = mvc(VT,P,E);
    MV(I,:) = P1;