1 // Compute right hand sides
2 #include "rhs.H"
3 4
// Update coordinates
5 x += deltaT * (lm/rho);
6 xF += deltaT * (lmC/rho);
7 xN += deltaT * (lmN/rho);
8 9
// Update cell linear momentum
10 lm += deltaT * rhs_lm;
11
12 // Update cell deformation gradient
13 if ( finiteVolumeMethod == "P-TOUCH" )
14 {
15 F += deltaT * rhs_F + (xi_F * (F_X - F));
16 }
17 else if ( finiteVolumeMethod == "C-TOUCH" || finiteVolumeMethod == "X-GLACE" )
18 {
19 F += deltaT * rhs_F;
20 }
21
22 // Update cell cofactor of deformation
23 if ( Hlaw == "yes" )
24 {
25 if ( finiteVolumeMethod == "P-TOUCH" )
26 {
27 H += deltaT * rhs_H + (xi_H * (H_F - H));
28 }
29 else if ( finiteVolumeMethod == "C-TOUCH" || finiteVolumeMethod == "X-GLACE" )
30 {
31 H += deltaT * rhs_H;
32 }
33 }
34
35 // Update cell Jacobian of deformation
36 if ( Jlaw == "yes" )
37 {
38 if ( finiteVolumeMethod == "P-TOUCH" )
39 {
40 J += deltaT * rhs_J + (xi_J * (J_F - J));
41 }
42 else if ( finiteVolumeMethod == "C-TOUCH" || finiteVolumeMethod == "X-GLACE")
43 {
44 J += deltaT * rhs_J;
45 }
46 }
47
48 // Update cell total energy
49 if ( Elaw == "yes" )
50 {
51 energy += deltaT * rhs_E;
52 }