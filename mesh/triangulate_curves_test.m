 clf;
 % get curve (user draws)
 Praw = {};
 while true
   [Prawc,p] = get_pencil_curve();
   if size(Prawc,1) == 1 || sum((max(Prawc)-min(Prawc)).^2,2)<1e-5
     fprintf('continuing\n');
     break;
   end
   Praw{end+1} = Prawc;
   %% remove plot
   %delete(p);
 end
 % Simplify
 P = cell(numel(Praw),1);
 for c = 1:numel(Praw)
   P{c} = dpsimplify(Praw{c},0.001);
 end
 [V,F,b,bc] = triangulate_curves(P);
 W = harmonic(V,F,b,bc);
 colors = random_color(4*numel(P));
 RGB = W * colors;
 tsurf(F,[V W(:,4)],'FaceVertexCData',clamp(RGB),fphong,'EdgeColor','none');axis equal;view(2)
