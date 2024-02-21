#ifndef _DOMAIN_D_CUH_
#define _DOMAIN_D_CUH_


namespace FVM

class Domain_d{
  public:
  Domain_d({}
  
  //GENERAL VARS
  unsigned int node_count, face_count, cell_count;
  
  unsigned int    *c_face_count;
  unsigned int    *c_offset; 
  unsigned int    *c_face;        //USES CELL_OFFSET c_face[c_offset[c]+nf] nf from 0 to c_face_count[c]
  
  ///////////////////////// CELL VARIABLES ///////////////////////////
  

  /// USED FOR REDUCTION ////  
  double          *c_flux;
  ///// END CELL VARS & FUNCTIONS /////////////////
  
  ///////////////////////// FACE VARIABLES ///////////////////////////
	double3       *vec_pn;											//Vector between baricenters
	double3       *e_pn;											  //Vector normalizado entre baricentros
	double        *ist_pn;										  //Distancia entre baricentros, antes se llamaba l
  unisgned int  *f_cell;                      //WHICH AN OFFSET OF CELL FACES
	double  *dist_pncorr;                                 //Orthogonal correction.
                                                        //This is the dist_pn projection to normal direction
                                                        //Is vec_pn*


	double *vec_pf_LR;				//Distancia del baricentro del cell al de la cara
	double *vec_normal_LR;		    //Vector normalizado y su opuesto, el primero apunta P-L y el otro hacia el vecino N-R
  double *Af;               //Face Area

	double *f_pn;                           //factor de interpolación a ambos lados
  //std::vector <Cell_CC> *pcell;                       //Puntero a cells



}; //DOMAIN_d

};

#endif