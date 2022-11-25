clear;
%%
[V,F] = subdivided_sphere(1);
E=edges(F);
[C] = adjacency_edge_cost_matrix(V,E);

[A,AE] = adjacency_incident_angle_matrix(V,E);