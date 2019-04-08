function [sc, fig] = sc_normals(sc, fig)
fig;
gcf;
hold on
subsections = fieldnames(sc);
count = 1;
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
                
                if count == 1
                    quiver3(bce(1), bce(2), bce(3),...
                        nv(1), nv(2), nv(3),'linewidth'...
                        , 3,'color','m','DisplayName','Unit Normals')
                    count = count + 1;
                else
                    quiver3(bce(1), bce(2), bce(3),...
                        nv(1), nv(2), nv(3),'linewidth'...
                        , 3,'color','m','HandleVisibility','off')
                end
                quiver3(bce(1), bce(2), bce(3),...
                    nv(1), nv(2), nv(3),'linewidth'...
                    , 3,'color','m','HandleVisibility','off')
                break
            end
        end

    end
end

end

