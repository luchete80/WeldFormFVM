/************************************************************************

	Copyright 2024-2024 Luciano Buglioni

	Contact: luciano.buglioni@gmail.com

	This file is a part of WeldFormFVM

	WeldFormFVM is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.

    FluxSol is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    For a copy of the GNU General Public License,
    see <http://www.gnu.org/licenses/>.

*************************************************************************/
#ifndef _DIV_H_
#define _DIV_H_

// #include "./FiniteVolume/FvImp.h"
// #include "./FiniteVolume/FvExp.h"
// #include "./Type/Products.h"
// #include "./Type/Vec3d.h"
// #include "./Type/Scalar.h"
// #include "./Interpolation/CenterToFaceInterpolation.h"

// #include "DivScheme.h"

// #include "FieldOperations.h"
// #include "GeometricField.h"

//#include <time.h>

using namespace std;

namespace FVM{
  
  
//THIS IS THE ONE WHICH IS ACTUALLY WORKING
// template <class T>
// //EqnSystem < typename innerProduct < Vec3D, T> ::type >
// //First arg is flux
// EqnSystem < T >
// FvImp::Div(GeomSurfaceField<Scalar> FluxField,_CC_Fv_Field <T> phi)
// {

__device__ Domain_d::Div_x_cell(const double *c_field_in, double *c_field_out){ 
  int c = threadIdx.x + blockDim.x*blockIdx.x;
  for (int fc=0;fc<c_face_count[c];fc++){
    
  }
}
        // clock_t ittime_begin, ittime_end;
    // double ittime_spent;
    // ittime_end = clock();


    // EqnSystem < T > eqnsys(phi.Grid());

    // const int numcells = phi.Grid().Num_Cells();


    // ittime_spent = (double)(clock() - ittime_end) / CLOCKS_PER_SEC;
    // ittime_end = clock();
    // cout << "div field gen "<<ittime_spent <<endl;


    // ittime_end = clock();
    // Scalar coeff_ap, coeff_an;
    // int cell[2];
    // int neigh,neigh2;

    // std::set<int>::iterator it;
    // std::set<int> *nff=&phi.IntNetFluxFaces();
	// for (it=nff->begin(); it!=nff->end(); ++it)
    // {
        // int f=*it;

        // cell[0]=phi.ConstGrid().Face(*it).Cell(0);

            // if(FluxField.Val(*it)>0.)
            // {
                // coeff_ap= FluxField.Val(*it);
                // coeff_an= 0.;
            // }
            // else
            // {
                // coeff_ap= 0.;
                // coeff_an= FluxField.Val(*it);
            // }

            // eqnsys.Eqn(cell[0]).Ap()+=coeff_ap;


            // cell[1]=phi.ConstGrid().Face(*it).Cell(1);

            // neigh=phi.ConstGrid().Cell(cell[0]).SearchNeighbour(cell[1]);
            // neigh2=phi.ConstGrid().Cell(cell[1]).SearchNeighbour(cell[0]);
                // //cout << "Cell "<<cell[0]<< "neighbour: "<<neigh<<endl;

            // eqnsys.Eqn(cell[0]).An(neigh)+=coeff_an;

            // eqnsys.Eqn(cell[1]).Ap()-=coeff_an;
            
            // eqnsys.Eqn(cell[1]).An(neigh2)-=coeff_ap;


    // }//End Faces Loop
// //    ------------------
// //    Loop through faces
// //    ------------------
// //    TO MODIFY, CHAMGE ORDER BETWEEN IF AND FOR
    // //cout <<"boundary"<<endl;

        // ittime_spent = (double)(clock() - ittime_end) / CLOCKS_PER_SEC;
    // ittime_end = clock();
    // cout << "divergence interior faces loop "<<ittime_spent <<endl;
     // ittime_end = clock();

    // for (int p=0;p<phi.Grid().vBoundary().Num_Patches();p++) {

                // if (phi.Boundaryfield().PatchField(p).Type()==FIXEDVALUE)
                // {
                    // for (int f=0;f<phi.Grid().vBoundary().vPatch(p).Num_Faces();f++)
                    // {
                        // int idface=phi.Grid().vBoundary().vPatch(p).Id_Face(f);

                        // eqnsys.Eqn(phi.Grid().Face(idface).Cell(0)).Source()-=phi.Boundaryfield().PatchField(p).Val(f)*FluxField.Val(idface);
                    // }
                // }
                // else if (phi.Boundaryfield().PatchField(p).Type()==FIXEDGRADIENT)
                // {

                // }
    // }
    // //cout << "Returning laplacian"<<endl;
    // ittime_spent = (double)(clock() - ittime_end) / CLOCKS_PER_SEC;
    // ittime_end = clock();
    // cout << "div boundary faces loop "<<ittime_spent <<endl;


    // //cout << "returning div"<<endl;
    // return eqnsys;


}



};// FVM

#endif