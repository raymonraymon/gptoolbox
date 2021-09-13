    S = readSEL(sel_file_name);
    % convert survey style selection to regions
    R = (S==0)*1 + (S==2)*2;
    [b,bc] = region_boundary_conditions(R);