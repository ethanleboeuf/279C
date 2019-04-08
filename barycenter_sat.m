function [sc,fig] = barycenter_sat(sc,fig)
fig;
gcf;
hold on
subsections = fieldnames(sc);
for subsect = subsections'
    faces = fieldnames(sc.(subsect{1}));
    for face = faces'
        coord = sc.(subsect{1}).(face{1}).coord;
        bc = [mean(coord(:,1)),mean(coord(:,2)),mean(coord(:,3))];
        sc = setfield(sc,subsect{1},face{1},'bc',bc);
        scatter3(bc(1),bc(2),bc(3),25,'g','filled','HandleVisibility','off')
    end
end


end

