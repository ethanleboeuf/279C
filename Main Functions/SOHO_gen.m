function [sc, fig] = SOHO_gen(rect, base, sp, R, sc)
% Will generate structure with coordinates for the spacecraft components
%   Inputs are structs of the height, width, and breadth of the spacecraft
%   components


rectb = rect.b;
recth = rect.h;
rectw = rect.w;

baseh = base.h;
basew = base.w;
baseb = base.b;

sph = sp.h;
spw = sp.w;
spb = sp.b;

alph = 0.3;
%% Rect Prism 5 faces (one attached to the hexagon)
fig = figure();
Rectf1 = vert2rect([0,0], [rectw, rectb], 1, [recth+baseh -rectw/2 -rectb/2]);
fill3(Rectf1(:,1),Rectf1(:,2),Rectf1(:,3),'k','FaceAlpha', alph,'HandleVisibility','off')
hold on
xlabel('x, m')
ylabel('y, m')
zlabel('z, m')
grid on
Rectf2 = vert2rect([0,0], [recth, rectb], 2, [baseh rectw/2 -rectb/2]);
fill3(Rectf2(:,1),Rectf2(:,2),Rectf2(:,3),'k','FaceAlpha', alph,'HandleVisibility','off')

Rectf3 = vert2rect([0,0], [recth, rectw], 3, [baseh -rectw/2 rectb/2]);
fill3(Rectf3(:,1),Rectf3(:,2),Rectf3(:,3),'k','FaceAlpha', alph,'HandleVisibility','off')

Rectf4 = vert2rect([0,0], [recth, rectb], 2, [baseh -rectw/2 -rectb/2]);
fill3(Rectf4(:,1),Rectf4(:,2),Rectf4(:,3),'k','FaceAlpha', alph,'HandleVisibility','off')

Rectf5 = vert2rect([0,0], [recth, rectw], 3, [baseh -rectw/2 -rectb/2]);
fill3(Rectf5(:,1),Rectf5(:,2),Rectf5(:,3),'k','FaceAlpha', alph)


%% Base Rect 9 faces (square missing in middle where attaches to rect prism)
BR1 = vert2rect([0,0], [basew/2, baseb], 1, [0 -basew/2 -baseb/2]);
fill3(BR1(:,1),BR1(:,2),BR1(:,3),'b','FaceAlpha', alph,'HandleVisibility','off')

BRF1 = vert2rect([0,0], [basew/2, baseb], 1, [0 0 -baseb/2]);
fill3(BRF1(:,1),BRF1(:,2),BRF1(:,3),'r','FaceAlpha', alph,'HandleVisibility','off')

BRF2 = vert2rect([0,0], [baseh-sph, baseb], 2, [sph basew/2 -baseb/2]);
fill3(BRF2(:,1),BRF2(:,2),BRF2(:,3),'r','FaceAlpha', alph,'HandleVisibility','off')

BR3 = vert2rect([0,0], [baseh-sph, baseb], 2, [sph -basew/2 -baseb/2]);
fill3(BR3(:,1),BR3(:,2),BR3(:,3),'b','FaceAlpha', alph,'HandleVisibility','off')

BR4 = vert2rect([0,0], [baseh, basew/2], 3, [0 -basew/2 baseb/2]);
fill3(BR4(:,1),BR4(:,2),BR4(:,3),'b','FaceAlpha', alph,'HandleVisibility','off')

BRF4 = vert2rect([0,0], [baseh, basew/2], 3, [0 0 baseb/2]);
fill3(BRF4(:,1),BRF4(:,2),BRF4(:,3),'r','FaceAlpha', alph,'HandleVisibility','off')

BR5 = vert2rect([0,0], [baseh, basew/2], 3, [0 -basew/2 -baseb/2]);
fill3(BR5(:,1),BR5(:,2),BR5(:,3),'b','FaceAlpha', alph,'HandleVisibility','off')

BRF5 = vert2rect([0,0], [baseh, basew/2], 3, [0 0 -baseb/2]);
fill3(BRF5(:,1),BRF5(:,2),BRF5(:,3),'r','FaceAlpha', alph,'HandleVisibility','off')

BR6 = vert2rect([0,0], [(basew-rectw)/2, baseb], 1, [baseh -basew/2 -baseb/2]);
fill3(BR6(:,1),BR6(:,2),BR6(:,3),'b','FaceAlpha', alph,'HandleVisibility','off')

BRF7 = vert2rect([0,0], [(basew-rectw)/2, baseb], 1, [baseh basew/4 -baseb/2]);
fill3(BRF7(:,1),BRF7(:,2),BRF7(:,3),'r','FaceAlpha', alph,'HandleVisibility','off')

BR8 = vert2rect([0,0], [rectb/2, (baseb-rectw)/2], 1, [baseh -basew/4 rectb/2]);
fill3(BR8(:,1),BR8(:,2),BR8(:,3),'b','FaceAlpha', alph,'HandleVisibility','off')

BRF8 = vert2rect([0,0], [rectb/2, (baseb-rectw)/2], 1, [baseh 0 rectb/2]);
fill3(BRF8(:,1),BRF8(:,2),BRF8(:,3),'r','FaceAlpha', alph,'HandleVisibility','off')

BR9 = vert2rect([0,0], [rectb/2, (baseb-rectw)/2], 1, [baseh -basew/4 -baseb/2]);
fill3(BR9(:,1),BR9(:,2),BR9(:,3),'b','FaceAlpha', alph)

BRF9 = vert2rect([0,0], [rectb/2, (baseb-rectw)/2], 1, [baseh 0 -baseb/2]);
fill3(BRF9(:,1),BRF9(:,2),BRF9(:,3),'r','FaceAlpha', alph)

%% Solar Panel #1 5 faces
SP11 = vert2rect([0,0], [spw, spb], 1, [0 basew/2 -baseb/2]);
fill3(SP11(:,1),SP11(:,2),SP11(:,3),'c','FaceAlpha', alph,'HandleVisibility','off')

SP12 = vert2rect([0,0], [spw, spb], 1, [sph basew/2 -baseb/2]);
fill3(SP12(:,1),SP12(:,2),SP12(:,3),'c','FaceAlpha', alph,'HandleVisibility','off')

SP13 = vert2rect([0,0], [sph, spb], 2, [0 basew/2+spw -baseb/2]);
fill3(SP13(:,1),SP13(:,2),SP13(:,3),'c','FaceAlpha', alph,'HandleVisibility','off')

SP14 = vert2rect([0,0], [sph, spw], 3, [0 basew/2 baseb/2]);
fill3(SP14(:,1),SP14(:,2),SP14(:,3),'c','FaceAlpha', alph,'HandleVisibility','off')

SP15 = vert2rect([0,0], [sph, spw], 3, [0 basew/2 -baseb/2]);
fill3(SP15(:,1),SP15(:,2),SP15(:,3),'c','FaceAlpha', alph)
%% Solar Panel #2 5 faces
SP21 = vert2rect([0,0], [spw, spb], 1, [0 -basew/2-spw -baseb/2]);
fill3(SP21(:,1),SP21(:,2),SP21(:,3),'c','FaceAlpha', alph,'HandleVisibility','off')

SP22 = vert2rect([0,0], [spw, spb], 1, [sph -basew/2-spw -baseb/2]);
fill3(SP22(:,1),SP22(:,2),SP22(:,3),'c','FaceAlpha', alph,'HandleVisibility','off')

SP23 = vert2rect([0,0], [sph, spb], 2, [0 -(basew/2+spw) -baseb/2]);
fill3(SP23(:,1),SP23(:,2),SP23(:,3),'c','FaceAlpha', alph,'HandleVisibility','off')

SP24 = vert2rect([0,0], [sph, spw], 3, [0 -basew/2-spw baseb/2]);
fill3(SP24(:,1),SP24(:,2),SP24(:,3),'c','FaceAlpha', alph,'HandleVisibility','off')

SP25 = vert2rect([0,0], [sph, spw], 3, [0 -basew/2-spw -baseb/2]);
fill3(SP25(:,1),SP25(:,2),SP25(:,3),'c','FaceAlpha', alph,'HandleVisibility','off')

axis equal
title('Simplified Geometry of SOHO')
quiver3(ones(3,1)*sc.CM(1),ones(3,1)*sc.CM(2),ones(3,1)*sc.CM(3),[1;0;0],[0;1;0],[0;0;1],0,'linewidth',3,'color','g')
quiver3(ones(3,1)*sc.CM(1),ones(3,1)*sc.CM(2),ones(3,1)*sc.CM(3), R(:,1), R(:,2), R(:,3),0, 'linewidth',3,'color',[102/255 0/255 51/255])
legend('Scientific Payload Section', 'Base', 'Base with Fuel Tank', 'Solar Panels','Body Axes','Principal Axes')

hold off

sc.rect.f1.coord = Rectf1;
sc.rect.f2.coord = Rectf2;
sc.rect.f3.coord = Rectf3;
sc.rect.f4.coord = Rectf4;
sc.rect.f5.coord = Rectf5;
sc.base.f1.coord = BR1;
sc.base.f2.coord = BR3;
sc.base.f3.coord = BR4;
sc.base.f4.coord = BR5;
sc.base.f5.coord = BR6;
sc.base.f6.coord = BR8;
sc.base.f7.coord = BR9;
sc.fuel.f1.coord = BRF1;
sc.fuel.f2.coord = BRF2;
sc.fuel.f3.coord = BRF4;
sc.fuel.f4.coord = BRF5;
sc.fuel.f5.coord = BRF7;
sc.fuel.f6.coord = BRF8;
sc.fuel.f7.coord = BRF9;
sc.sp1.f1.coord = SP11;
sc.sp1.f2.coord = SP12;
sc.sp1.f3.coord = SP13;
sc.sp1.f4.coord = SP14;
sc.sp1.f5.coord = SP15;
sc.sp2.f1.coord = SP21;
sc.sp2.f2.coord = SP22;
sc.sp2.f3.coord = SP23;
sc.sp2.f4.coord = SP24;
sc.sp2.f5.coord = SP25;
end