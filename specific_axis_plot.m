function specific_axis_plot(data, axis_name)
n = size(data,2);
figure('units','normalized','outerposition',[0 0 1 1])
incr = 10;
for ii = 1:incr:n - incr
    
    clrs = [ii / n, 0 , ii / n];
    plot3([data(1,ii), data(1,ii+incr)], [data(2,ii), data(2,ii+incr)],...
        [data(3,ii), data(3,ii+incr)], 'color', clrs)
    hold on
end
title_str = [axis_name, '-axis over time'];
title(title_str)
xlabel('x')
ylabel('y')
zlabel('z')
hold off

end

