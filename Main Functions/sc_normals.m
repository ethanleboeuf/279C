function [sc, fig] = sc_normals(sc, fig)
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
x_cm = sc.CM(1);
y_cm = sc.CM(2);
z_cm = sc.CM(3);
for subsect = subsections'
    faces = fieldnames(sc.(subsect{1}));
    for face = faces'
        coord = sc.(subsect{1}).(face{1}).coord;
        for ii = 1:size(coord,2)
            if range(coord(:,ii)) == 0
                nv = zeros(3,1);
                bce = sc.(subsect{1}).(face{1}).bc;
                if sign(bce(ii) - eps) > 0
                    nv(ii) = 1;
                else
                    nv(ii) = -1;
                end
                sc = setfield(sc,subsect{1},face{1},'normal',nv);
                if plot_flag == 1
                    if count == 1
                        quiver3(bce(1)+x_cm, bce(2)+y_cm, bce(3)+z_cm,...
                            nv(1), nv(2), nv(3),'linewidth'...
                            , 3,'color','r','DisplayName','Unit Normals')
                        count = count + 1;
                    else
                        quiver3(bce(1)+x_cm, bce(2)+y_cm, bce(3)+z_cm,...
                            nv(1), nv(2), nv(3),'linewidth'...
                            , 3,'color','r','HandleVisibility','off')
                    end
                end
%                 quiver3(bce(1), bce(2), bce(3),...
%                     nv(1), nv(2), nv(3),'linewidth'...
%                     , 3,'color','r','HandleVisibility','off')
                break
            end
        end

    end
end

end

