function [sc,fig] = barycenter_sat(sc,fig)
if isempty(fig)
    fig = 1;
    plot_flag = 0;
else
    plot_flag = 1;
    
end
fig;
gcf;
hold on
subsections = fieldnames(sc);
subsections = {'rect';'base';'fuel';'sp1';'sp2'};
count = 1;
for subsect = subsections'
    faces = fieldnames(sc.(subsect{1}));
    for face = faces'
        coord = sc.(subsect{1}).(face{1}).coord;
        bc = [mean(coord(:,1)),mean(coord(:,2)),mean(coord(:,3))] - sc.CM;
        sc = setfield(sc,subsect{1},face{1},'bc',bc);
        if plot_flag == 1
            if count == 1
                scatter3(bc(1)+sc.CM(1),bc(2)+sc.CM(2),bc(3)+sc.CM(3),25,'k','filled','DisplayName',...
                    'Barycenters')
                count = count + 1;
            else
                scatter3(bc(1)+sc.CM(1),bc(2)+sc.CM(2),bc(3)+sc.CM(3),25,'k','filled','HandleVisibility'...
                    ,'off')
            end
        end
    end
end
end

