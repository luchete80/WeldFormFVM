1 #include "constitutiveModel.H" // Compute PK1 stresses
2 3
if ( reconstruction == "linear" )
4 {
5 #include "gradients.H" // Least square gradient calculation
6 #include "reconstruction.H" // Linear reconstruction procedure
7 }
8 9
#include "acousticRiemannSolver.H" // Calculate contact fluxes
10 #include "nodalLinearMomentum.H" // Obtain nodal linear momentum pN
11 #include "strongBoundaryConditions.H" // Impose strong boundary conditions on pN
12
13 if ( finiteVolumeMethod == "C-TOUCH" )
14 {
15 interpolate.pointToSurface(lmN, lmC);
16 }