%equalize_valences
function [V,F] = equalize_valences(V,F,feature)

% feature edges fixed

vN = size(V,1);
valences = zeros(vN,1);
for i = 1:size(F,1)
    valences(F(i,1)) =  valences(F(i,1))+1;
    valences(F(i,2)) =  valences(F(i,2))+1;
    valences(F(i,3)) =  valences(F(i,3))+1;
end

  E = edges(F);
  ET = edge_triangle_adjacency(F,E);
  uE = E;
  ring = compute_vertex_ring(F);
  for i = 1:size(uE,1)
      if ET(i,1) == -1 || ET(i,2) == -1
          continue;
      end
      is_feature_edge = false;
      a = E(i,1);
      b = E(i,2);
      c = setdiff(F(ET(i,1),:),uE(i,:),'stable');
      d = setdiff(F(ET(i,2),:),uE(i,:),'stable');
      
	  
      bad = false;      
	  if ismember(ring{c},d)
		bad = true;
	  end 
	  
	  
      if any(ismember(feature,[a,b,c,d]))
          is_feature_edge = true;
      end
      
           % f1_new
           a1 = norm(V(a,:)-V(c,:));
           b1 = norm(V(a,:)-V(d,:));
           c11 = norm(V(d,:)-V(c,:));
           s1 = (a1+b1+c11)/2;
           area_1_squared = s1*(s1-a1)*(s1-b1)*(s1-c11);
           % f2_new
           a2 = norm(V(b,:)-V(c,:));
           b2 = norm(V(b,:)-V(d,:));
           c22 = norm(V(d,:)-V(c,:));
           s2 = (a2+b2+c22)/2;
           area_2_squared = s2*(s2-a2)*(s2-b2)*(s2-c22);
          
          v21 = V(b,:)-V(a,:);
          v31 = V(c,:)-V(a,:);
          v41 = V(d,:)-V(a,:);
          v24 = V(b,:)-V(d,:);
          v34 = V(c,:)-V(d,:);
          v43 = V(d,:)-V(c,:);
          v23 = V(b,:)-V(c,:);
          normf10 = cross(v21,v31);
          normf11 = cross(v41,v31);
          normf12 = cross(v24,v34);
          normf20 = cross(v41,v21);
          normf21 = cross(v43,v23);
          normf22 = cross(v41,v31);
          normf10 = normalizerow(normf10);
          normf11 = normalizerow(normf11);
          normf12 = normalizerow(normf12);
          normf20 = normalizerow(normf20);
          normf21 = normalizerow(normf21);
          normf22 = normalizerow(normf22);
          
          if (dot(normf10,normf11) < norm(normf11)/2 || dot(normf10,normf12) < norm(normf12)/2) 
              bad = true;
          end
          if (dot(normf20,normf21) < norm(normf21)/2 || dot(normf20,normf22) < norm(normf22)/2) 
              bad = true;
          end
		  
		  

        if (area_1_squared <= 0) 
            bad = true;
        end
        if (area_2_squared <= 0) 
            bad = true;
        end
      
      if ~is_feature_edge
          pre = abs(valences(a)-6)+abs(valences(b)-6)+abs(valences(c)-6)+abs(valences(d)-6);
          post = abs(valences(a)-6-1)+abs(valences(b)-6-1)+abs(valences(c)-6+1)+abs(valences(d)-6+1);
          if pre > post && ~bad
              
              [F] = flip_edges(F,E(i,:));
              uE = edges(F);
              ET = edge_triangle_adjacency(F,uE);
			  ring = compute_vertex_ring(F);
              valences(a) = valences(a)-1;
              valences(b) = valences(b)-1;
              valences(c) = valences(c)+1;
              valences(d) = valences(d)+1;              
          end
      end
  end
end