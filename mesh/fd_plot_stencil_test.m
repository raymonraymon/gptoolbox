    Q = fd_laplacian([5 5]);
    fd_plot_stencil([5 5],Q(ceil(end/2),:));