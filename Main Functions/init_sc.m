function [sc] = init_sc()

body_principal_inertia
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
[sc] = barycenter_sat(sc, []);
sc = sc_area(sc);
[sc] = sc_normals(sc, []);
close all
end

