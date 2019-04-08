function [sc,fig] = barycenter_sat(sc,fig)
fig;
gcf;
hold on
subsections = fieldnames(sc);
count = 1;
for subsect = subsections'
    faces = fieldnames(sc.(subsect{1}));
    for face = faces'
        coord = sc.(subsect{1}).(face{1}).coord;
        bc = [mean(coord(:,1)),mean(coord(:,2)),mean(coord(:,3))];
        sc = setfield(sc,subsect{1},face{1},'bc',bc);
        if count == 1
            scatter3(bc(1),bc(2),bc(3),25,'y','filled','DisplayName',...
                'Barycenters')
            count = count + 1;
        else
            scatter3(bc(1),bc(2),bc(3),25,'y','filled','HandleVisibility'...
                ,'off')
        end
    end
end


end

