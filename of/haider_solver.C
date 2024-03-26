1 /*------------------------------------------------------------------------------------*\
2 ========= |
3 \\ / F ield | OpenFOAM: The Open Source CFD Toolbox
4 \\ / O peration |
5 \\ / A nd | Copyright (C) 2011-2017 OpenFOAM Foundation
6 \\/ M anipulation |
7 ----------------------------------------------------------------------------------------
8 License
9 This file is part of OpenFOAM.
10
11 OpenFOAM is free software: you can redistribute it and/or modify it under the
12 terms of the GNU General Public License as published by the Free Software
13 Foundation, either version 3 of the License, or (at your option) any later version.
14
15 OpenFOAM is distributed in the hope that it will be useful, but WITHOUT ANY
16 WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
17 PARTICULAR PURPOSE. See the GNU General Public License for more details.
18
19 Application
20 mixedSolidFoam
21
22 Description
23 A large strain solid mechanics solver based on a linear momentum/strains mixed
24 formualtion. It employs a Total Lagrangian formulation utilisiing an explicit
25 Total Variation Diminishing Runge-Kutta time integrator. A discrete angular momentum
26 projection algorithm based on two global Lagrange Multipliers is added for angular
27 momentum conservation.
28
29 \*-----------------------------------------------------------------------------------*/
30
31 // INCLUSION OF RELEVANT HEADER FILES
32 #include "fvCFD.H"
33 #include "pointFields.H"
34 #include "gradientSchemes.H"
35 #include "interpolationSchemes.H"
36 #include "operators.H"
37
38 // * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //
39
40 int main(int argc, char *argv[])
41 {
42 #include "setRootCase.H" // Set path and case directories
43 #include "createTime.H" // Initialise time variable
44 #include "createMesh.H" // Generate mesh for the problem
45 #include "readControls.H" // Read simulation control parameters
46 #include "meshData.H" // Define variables based on mesh
47 #include "createFields.H" // Define problem variables
48
49 // TIME LOOP
50 while (runTime.loop())
51 {
52 // Calculate time increment
53 if (timeStepping == "variable")
54 {
55 deltaT = (cfl*h) / max(Up_time);
56 runTime.setDeltaT(deltaT);
57 }
58
59 // Compute time and time step
60 t += deltaT;
61 tstep++;