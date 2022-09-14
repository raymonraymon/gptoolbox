function [vol] = volume_triangleMesh(V,F)
 vol= 0;
 volplus= 0;
 volminus = 0;
 for i= 1:size(F,1)
     r = signedVolumeOfTriangle(V(F(i,1),:),V(F(i,2),:),V(F(i,3),:));
     vol = vol + r;
     if r < 0
         volminus =volminus+r;
     else
         volplus = volplus+r;
     end
 end

  function r = signedVolumeOfTriangle(p1,p2,p3)
     v321 = p3(1)*p2(2)*p1(3);
     v231 = p2(1)*p3(2)*p1(3);
     v312 = p3(1)*p1(2)*p2(3);
     v132 = p1(1)*p3(2)*p2(3);
     v213 = p2(1)*p1(2)*p3(3);
     v123 = p1(1)*p2(2)*p3(3);
     r = (1.0/6.0)*(-v321 + v231 + v312 - v132 - v213 + v123);
  end
end
