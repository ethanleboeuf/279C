%% Kinematics Plotting
clear all
close all
sc = init_sc();
sc = body_inertia_func(sc);
I_vec = [sc.Ip(1,1); sc.Ip(2,2); sc.Ip(3,3)];

k_N = (I_vec(2) - I_vec(1))/I_vec(3);
k_T = (I_vec(3) - I_vec(1))/I_vec(2);
k_R = (I_vec(3) - I_vec(2))/I_vec(1);


v = -1:.005:1; 
[x, y] = meshgrid(v);

cond1 = x > y;
cond1 = double(cond1);
cond1(cond1==0) = NaN;

cond2 = x .* y > 0;
cond2 = double(cond2);
cond2(cond2==0) = NaN;

cond3 = abs(1 + 3.*x + x.*y) > real(4 .* sqrt(x.*y));
cond3 = double(cond3);
cond3(cond3==0) = NaN;

n = length(v);
CO(:,:,1) = zeros(n); % red
CO(:,:,2) = ones(n).*0.5; % green
CO(:,:,3) = ones(n) .* 1; % blue

cond = cond1 .* cond2 .* cond3;
figure('units','normalized','outerposition',[0 0 1 1])
surf(x,y,cond1, 'FaceColor',[0 0 1], 'FaceAlpha', 1, 'EdgeColor', 'none');
hold on
surf(x,y, cond2, 'FaceColor',[1 1 0], 'FaceAlpha', 0.75, 'EdgeColor', 'none');
surf(x,y, cond3, 'FaceColor',[0 1 0], 'FaceAlpha', 0.5, 'EdgeColor', 'none');
surf(x,y, cond, 'FaceColor',[1 0 1], 'FaceAlpha', 1, 'EdgeColor', 'none');
scatter3(k_T, k_R, 1, 'filled','k')
view(0,90)
legend('$$k_T > k_R$$', '$$k_Tk_R > 0$$', '$$1 + 3k_T + k_Tk_R > 4\sqrt{k_Tk_R}$$'...
    ,'Overlap', 'Satellite Value', 'Interpreter', 'latex')
xlabel('K_T')
ylabel('K_R')
title('Stability with Gravity Gradient')
hold off