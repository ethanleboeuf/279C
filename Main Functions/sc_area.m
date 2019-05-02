function [sc] = sc_area(sc)

subsections = fieldnames(sc);
subsections = {'rect';'base';'fuel';'sp1';'sp2'};
poss = [1 2 3];
for subsect = subsections'
    faces = fieldnames(sc.(subsect{1}));
    for face = faces'
        coord = sc.(subsect{1}).(face{1}).coord;
        for ii = 1:size(coord,2)
            if range(coord(:,ii)) == 0
                avail = poss(poss~=ii);
                area = abs((coord(3,avail(2)) - coord(1,avail(2))) *...
                    (coord(3,avail(1)) - coord(1,avail(1))));
                sc = setfield(sc,subsect{1},face{1},'area',area);
                break
            end
        end

    end
end

end

