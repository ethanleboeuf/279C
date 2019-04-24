function [fig] = polhode_ellipsoid_plots(w, I, pol)

Lvec = I * w;
L = norm(Lvec);
TwoT = dot(w, Lvec);

xr_ke = sqrt(TwoT/I(1,1));
yr_ke = sqrt(TwoT/I(2,2));
zr_ke = sqrt(TwoT/I(3,3));

xr_L = sqrt(L^2/I(1,1)^2);
yr_L = sqrt(L^2/I(2,2)^2);
zr_L = sqrt(L^2/I(3,3)^2);

[x_ke, y_ke, z_ke] = ellipsoid(0, 0, 0, xr_ke, yr_ke, zr_ke, 1000);
[x_L, y_L, z_L] = ellipsoid(0, 0, 0, xr_L, yr_L, zr_L, 1000);

%% Just Ellipses
fig = figure();
surf(x_ke, y_ke, z_ke, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor',...
    'red')
hold on
surf(x_L, y_L, z_L,'EdgeColor','none','FaceAlpha', 0.5, 'FaceColor',...
    'blue')
legend('Kinetic Energy Ellipsoid', 'Angular Momentum Ellipsoid')
xlabel('x, rad/s')
ylabel('y, rad/s')
zlabel('z, rad/s')
title('Ellipsoids')
axis equal
hold off

%% 3D Ellipse + Polhode
[fig] = polhode_finder(I, w, x_ke, x_L, y_ke, y_L);
figure(fig)
% figure()
hold on
surf(x_ke, y_ke, z_ke, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor',...
    'red')

surf(x_L, y_L, z_L,'EdgeColor','none','FaceAlpha', 0.5, 'FaceColor',...
    'blue')
% 
% scatter3(pol(:,1), pol(:,2), pol(:,3),'k','filled')
xlabel('x, rad/s')
ylabel('y, rad/s')
zlabel('z, rad/s')
title('Ellipsoids with Polhode')
axis equal
hold off


%% 3D Ellipse + vel
figure()
surf(x_ke, y_ke, z_ke, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor',...
    'red')
hold on
surf(x_L, y_L, z_L,'EdgeColor','none','FaceAlpha', 0.5, 'FaceColor',...
    'blue')

scatter3(pol(:,1), pol(:,2), pol(:,3),'k','filled')
scatter3(pol(:,1), pol(:,2), -pol(:,3),'k','filled') % take this out after plotting
xlabel('x, rad/s')
ylabel('y, rad/s')
zlabel('z, rad/s')
title('Ellipsoids with Polhode')
axis equal
hold off

%% 2D Plots
figure()
subplot(3,1,1)
surf(x_ke, y_ke, z_ke, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor',...
    'red')
hold on
surf(x_L, y_L, z_L,'EdgeColor','none','FaceAlpha', 0.5, 'FaceColor',...
    'blue')
scatter3(pol(:,1), pol(:,2), pol(:,3),'k','filled')
scatter3(pol(:,1), pol(:,2), -pol(:,3),'k','filled') % take this out after plotting
view([0 -90 0])
hold on
xlabel('x, rad/s')
zlabel('z, rad/s')
grid on
hold off

subplot(3,1,2)
surf(x_ke, y_ke, z_ke, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor',...
    'red')
hold on
surf(x_L, y_L, z_L,'EdgeColor','none','FaceAlpha', 0.5, 'FaceColor',...
    'blue')
scatter3(pol(:,1), pol(:,2), pol(:,3),'k','filled')
scatter3(pol(:,1), pol(:,2), -pol(:,3),'k','filled') % take this out after plotting
hold on
view([90 0 0])
ylabel('y, rad/s')
zlabel('z, rad/s')
grid on
hold off

subplot(3,1,3)
surf(x_ke, y_ke, z_ke, 'EdgeColor', 'none', 'FaceAlpha', 0.5, 'FaceColor',...
    'red')
hold on
surf(x_L, y_L, z_L,'EdgeColor','none','FaceAlpha', 0.5, 'FaceColor',...
    'blue')
scatter3(pol(:,1), pol(:,2), pol(:,3),'k','filled')
scatter3(pol(:,1), pol(:,2), -pol(:,3),'k','filled') % take this out after plotting
view([0 0 90])
hold on
xlabel('x, rad/s')
ylabel('y, rad/s')
grid on
hold off

sgtitle(['Planar Views of the Polhode on the Ellipsoids'])

end

