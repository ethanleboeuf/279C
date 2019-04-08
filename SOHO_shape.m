%% Satellite Generator
close all
clear all

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
[sc, fig] = SOHO_gen(rect, base, sp);
[sc, fig] = barycenter_sat(sc, fig);
sc = sc_area(sc);
[sc, fig] = sc_normals(sc, fig);