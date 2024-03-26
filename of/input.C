1 /*-------------------------------------*- C++ -*---------------------------------------*\
2 | ========= | |
3 | \\ / F ield | OpenFOAM: The Open Source CFD Toolbox |
4 | \\ / O peration | Version: 5 |
5 | \\ / A nd | Web: www.OpenFOAM.org |
6 | \\/ M anipulation | |
7 \*-------------------------------------------------------------------------------------*/
8 9
// Simulation
10 //-----------
11 tutorial twistingColumn;
12 nProc 6;
13 meshFormat gmsh;
14
15 // Initial condition
16 //------------------
17 angularVelocityY 105;
18
19 // Mechanical properties
20 //---------------------
21 problemType nonLinear; // Options: {linear}
22 model neoHookean; // Options: {hyperElasticPlastic, linearElastic}
23 density 1100; // Units: kg/m^3
24 PoissonsRatio 0.45;
25 YoungsModulus 17e6; // Units: Pa
26
27 // Time stepping
28 //--------------
29 timeStepping variable;
30 cfl 0.3;
31 deltaT 0; // Used only for ’constant’ time stepping
32 endTime 0.25
33 writeControl runTime;
34 writeInterval 0.01;
35
36 // Solver settings
37 //----------------
38 Jlaw no; // J conservation law
39 Hlaw no; // H conservation law
40 Elaw no; // E conservation law
41
42 FVM C-TOUCH; // Options: {P-TOUCH, X-GLACE}
43 xi_F 0.1; xi_H 0.1; xi_J 0.1; // Penalisation factors for P-TOUCH scheme
44
45 enhancedGradient yes; // Useful in the presence of fixed boundaries
46 limiter no; // Slope limiter for cell gradients
47 reconstruction linear; // Options: {constant}
48
49 riemannWaveSpeeds uniform; // Options: {nonuniform}
50 incompressiblilityCoefficient 1.0; // Parameter for preconditioned dissipation in RS
51
52 timeIntegration twoStepRK; // Options: forwardEuler
53 angularMomentumConservation yes;
54
55 globalData yes;