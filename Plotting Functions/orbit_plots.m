function orbit_plots(y_out)
constants
mu1 = 328900.56^-1; % From NASA
omega = sqrt((mu.earth + mu.sun)/dis.sun^3);


syms x
eqn = x - (1-mu1)/(x+mu1)^2 + mu1/(x-1+mu1)^2 == 0;
digitsOld = digits(100);
L1 = vpasolve(eqn,x,[0,1]);

figure()
plot(y_out(:,1), y_out(:,2),'k','LineWidth',3)
hold on
% plot(y_out(:,7), y_out(:,8))
scatter(double(L1)*dis.sun,0,100,'filled','r')
% scatter(mu1*dis.sun,0,25,'filled')
scatter((1-mu1)*dis.sun,0,100,'filled','b')
title('Halo Orbit around L1 Point in the Rotating Barycenter Frame')
xlabel('x position, km')
ylabel('y position, km')
% axis equal
grid on
legend('Halo Orbit', 'L1 Point', 'Earth')
hold off
(y_out(1,1) - y_out(end,1)) %check on final error in the distance



figure()
subplot(3,1,1)
plot3(y_out(:,1),y_out(:,2),y_out(:,3),'k','LineWidth',3)
view([0 -90 0])
hold on
scatter3(double(L1)*dis.sun,0,0,100,'filled','r')
xlabel('x, km')
zlabel('z, km')
grid on
hold off

subplot(3,1,2)
plot3(y_out(:,1),y_out(:,2),y_out(:,3),'k','LineWidth',3)
hold on
scatter3(double(L1)*dis.sun,0,0,100,'filled','r')
view([90 0 0])
ylabel('y, km')
zlabel('z, km')
grid on
hold off

subplot(3,1,3)
plot3(y_out(:,1),y_out(:,2),y_out(:,3),'k','LineWidth',3)
view([0 0 90])
hold on
scatter3(double(L1)*dis.sun,0,0,100,'filled','r')
xlabel('x, km')
ylabel('y, km')
grid on
hold off

sgtitle(['Different views of the Halo Orbit around the {\color{red}L1} point'])
end

