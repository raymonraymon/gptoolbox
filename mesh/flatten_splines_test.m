    [P,C,I,F,S,SW,D] = readSVG_cubics('../models/simple_rotor.svg');
    [PR,CR] = flatten_splines(P,C,I,F,S,SW,D);
    plot_spline(PR,CR);
    set(gca,'YDir','reverse')
    axis equal;