function [verts,area] = vert2rect(lo,hi,perpface,translation)
% perp face is the normal of the face. 1 is x, 2 is y and 3 is z
verts = zeros(4,3);
if perpface == 1
    verts(1,[2,3]) = lo;
    verts(3,[2,3]) = hi;
    verts(2,[2,3]) = [lo(1), hi(2)];
    verts(4,[2,3]) = [hi(1), lo(2)];
elseif perpface == 2
    verts(1,[1,3]) = lo;
    verts(3,[1,3]) = hi;
    verts(2,[1,3]) = [lo(1), hi(2)];
    verts(4,[1,3]) = [hi(1), lo(2)]; 
elseif perpface == 3
    verts(1,[1,2]) = lo;
    verts(3,[1,2]) = hi;
    verts(2,[1,2]) = [lo(1), hi(2)];
    verts(4,[1,2]) = [hi(1), lo(2)]; 
end
for ii = 1:size(verts,1)
    verts(ii,:) = verts(ii,:) + translation;
end
area = (hi(1) - lo(1)) * (hi(2) - lo(2));
end
