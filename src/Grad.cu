namespace FVM {

__global__ Domain_d::Grad () {
  
  
      // _CC_Fv_Field < typename outerProduct<Vec3D, T>::type > r(field.Grid());

      // int cell[2];
      // std::set<int>::iterator it;
      // std::set<int> *nff=&field.IntNetFluxFaces();

      // //Cell center Gauss Gradient
      // _CC_Fv_Field < typename outerProduct<Vec3D, T>::type > gradp= FvExp::Grad (field);



      // //Field Interpolation
      // //_CC_Fv_Field < typename outerProduct<Vec3D, T>::type > fi_fo(field.Grid());

      // //Gradient Interpolation
      // GeomSurfaceField < typename outerProduct<Vec3D, T>::type > grad_fo = Interpolate(gradp);

      // GeomSurfaceField <T> field_f(field);

      // //FI_FO IS A CONSTANT VALUE
      // GeomSurfaceField <T> fi_fo=Interpolate(field);    //INITIAL VALUES OF FACEFI

      // field_f=fi_fo;  //Initial value


      // double3 fo_f;

      // double afdir[2];afdir[0]=1.;afdir[1]=-1.;

      // bool end=false;
      // int numcorr=5;
      // int corrit=0;


      // // NON ORTHOGONAL CORRECTIONS
      // // Calculate gradient at faces
      // cout << "Loop Through faces"<<endl;
      // while (!end)
      // {

          // r=0.;
          // cout << "Creating gradient r"<<endl;
           // // EQN (1) GRADIENT CALC
           // // INTERNAL OR EXTERNAL??
          // for (int f=0;f<r.Grid().Num_Faces();f++)
          // {
              // for (int fc=0;fc<r.Grid().Face(f).NumCells();fc++)
              // {
                  // int c=r.Grid().Face(f).Cell(fc);
                  // r[c]+=r.Grid().Face(f).Af()*field_f[f]*afdir[fc];
              // }
          // }

          // int c;
          // for (c=0,r.Grid().cellit=r.Grid().BeginCell(); r.Grid().cellit!=r.Grid().EndCell(); r.Grid().cellit++,c++)
              // r[c]=r[c]/r.Grid().cellit->Vp();

          // grad_fo = Interpolate(r);

          // //Loop through Net Flux Faces (nff) via iterator
          // //ALL FACES IS NOT SENSE, BOUNDARY FACES HAVE ZERO FO_F VALUE
          // cout << "Loop trough faces"<<endl;
          // for (int f=0;f<r.Grid().Num_Faces();f++)
          // {
              // int f=*it;
              // cell[0]=field.ConstGrid().Face(f).Cell(0);

              // cout << "PF"<<field.ConstGrid().Face(f).Dist_pf_LR(0) <<endl;
// //                    fo_f=   field.ConstGrid().Face(f).Dist_pf_LR(0)- (
// //                            ( field.ConstGrid().Face(f).Dist_pf_LR(0) & (field.ConstGrid().Face(f).e_PN()) ) *
// //                             field.ConstGrid().Face(f).e_PN() );
// //    //                       //Dist_pf_LR
              // cout << "dist fo_f"<<endl;
              // cout << fo_f.outstr()<<endl;

              // field_f[f]=fi_fo[f]+(grad_fo[f]&field.ConstGrid().Face(f).fof());        // EQN (2)


          // }   //For net flux faces
          // cout <<"end of iteration"<<endl;

          // if (corrit <=numcorr)   end=true;
          // corrit++;
      // }
      // cout << "returning grad"<<endl;
      // cout <<r.outstr()<<endl;
      // return r;
  } // End of NonOrthGrad
  
} 

__global__ Grad(){
  
}

//////////////// SLOWER THAN PER FACE
//////////////// PER CELL
//////////////// DOES NOT REQUIRE REDUCTION
__device__ Domain_d::Grad_x_Cell(){
  int c = threadIdx.x + blockDim.x*blockIdx.x;
  for (int fc=0;fc<c_face_count[c];fc++){
    
  }
}
        
}; //FVM