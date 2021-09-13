  
   [NV,NF,OV,OE,OV1,OE1] = remesh_at_handles(V,F,C,P,BE,CE);
   % show a plot of what's sent to triangle
   subplot(3,1,1);
   plot([OV1(OE1(:,1),1) OV1(OE1(:,2),1)]',[OV1(OE1(:,1),2) OV1(OE1(:,2),2)]','-','LineWidth',1);
   hold on;
   plot(OV1(:,1),OV1(:,2),'.');
   hold off;
   axis equal;
   title('Outline + handle samples');
   subplot(3,1,2);
   plot([OV(OE(:,1),1) OV(OE(:,2),1)]',[OV(OE(:,1),2) OV(OE(:,2),2)]','-','LineWidth',1);
   hold on;
   plot(OV(:,1),OV(:,2),'.');
   hold off;
   axis equal;
   title('Input to triangle (collapsed points + split edges)');
   % show a plot of the result
   subplot(3,1,3);
   tsurf(NF,NV);
   hold on;
   plot([OV(OE(:,1),1) OV(OE(:,2),1)]',[OV(OE(:,1),2) OV(OE(:,2),2)]','-','LineWidth',2);
   hold off;
   axis equal;
   title('Output of triangle');