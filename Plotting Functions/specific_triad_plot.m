function specific_triad_plot(x, y , z, triad_name)
n = size(x,2);
figure('units','normalized','outerposition',[0 0 1 1])
incr = floor(n/100);
for ii = 1:incr: n
    if ii == 1
        quiver3(0, 0, 0, x(1,ii), x(2,ii), x(3,ii), 'r','LineWidth',2)
        hold on
        quiver3(0, 0, 0, y(1,ii), y(2,ii), y(3,ii), 'b','LineWidth',2)
        quiver3(0, 0, 0, z(1,ii), z(2,ii), z(3,ii), 'g','LineWidth',2)
    else
        quiver3(0, 0, 0, x(1,ii), x(2,ii), x(3,ii), 'r','LineWidth',2 ...
            ,'HandleVisibility','off')
        quiver3(0, 0, 0, y(1,ii), y(2,ii), y(3,ii), 'b','LineWidth',2 ...
            ,'HandleVisibility','off')
        quiver3(0, 0, 0, z(1,ii), z(2,ii), z(3,ii), 'g','LineWidth',2 ...
            ,'HandleVisibility','off')
    end

end
quiver3(0,0,0,1,0,0,'k','LineWidth',5)
quiver3(0,0,0,0,1,0,'k','LineWidth',5,'HandleVisibility','off')
quiver3(0,0,0,0,0,1,'k','LineWidth',5,'HandleVisibility','off')
title_str = [triad_name, ' axes over time'];
title(title_str)        
xlabel('I')
ylabel('J')
zlabel('K')
if strcmp(triad_name, 'Principal')
    l_1 = 'x';
    l_2 = 'y';
    l_3 = 'z';
elseif strcmp(triad_name, 'Body')
    l_1 = 'b_x';
    l_2 = 'b_y';
    l_3 = 'b_z';
elseif strcmp(triad_name, 'RTN')
    l_1 = 'R';
    l_2 = 'T';
    l_3 = 'N';
else
    l_1 = 'x';
    l_2 = 'y';
    l_3 = 'z';
end
legend(l_1, l_2, l_3, 'Inertial Axes')
axis equal
hold off

end

