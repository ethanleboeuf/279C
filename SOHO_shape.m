%% Satellite Generator
close all
clear all
set(0,'DefaultLineLineWidth',1.5)
set(0,'DefaultLineMarkerSize',15)
set(0,'DefaultAxesFontSize',22)
set(0,'DefaultTextFontSize',26)
set(0,'DefaultFigureColor',[1,1,1])
body_principal_inertia
%% Geometry Parameters
rect.b = 1.85;
rect.h = 3.6;
rect.w = 1.85;

base.h = 0.7;
base.w = 3.7;
base.b = 2.7;

sp.h = 0.03;
sp.w = 2.9;
sp.b = 2.7;
[sc, fig] = SOHO_gen(rect, base, sp, R, sc);
[sc, fig] = barycenter_sat(sc, fig);
sc = sc_area(sc);
[sc, fig] = sc_normals(sc, fig);