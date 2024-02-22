#ifndef _DOMAIN_D_CUH_
#define _DOMAIN_D_CUH_


namespace FVM {

class Domain_d{
  public:
  Domain_d({}
  void Domain_d::AddBoxLength(double3 const & V, double3 const & L, const double &r, const bool &red_int = true);
  
  void SetDimension(const int &nc, const int &cc, const int &fc);
  
  //GENERAL VARS
  unsigned int node_count, face_count, cell_count;
  
  unsigned int    *m_c_face_count;
  unsigned int    *m_c_offset;      //IF NOT USED AS 4*CELL
  unsigned int    *m_c_face;        //USES CELL_OFFSET m_c_face[c_offset[c]+nf] nf from 0 to c_face_count[c]


  bool m_is_all_quads;  //DOES NOT USE OFFSET
  
  ///////////////////////// CELL VARIABLES ///////////////////////////
  

  /// USED FOR REDUCTION ////  
  double          *m_c_flux;
  
  double         *x, *v, *a;
  
  ///// END CELL VARS & FUNCTIONS /////////////////
  
  ///////////////////////// FACE VARIABLES ///////////////////////////
	double       *m_vec_pn;	 //Vector										//Vector between baricenters
	double3      *m_e_pn;											  //Vector normalizado entre baricentros
	double        *m_dist_pn;										  //Distancia entre baricentros, antes se llamaba l
  unsigned int  *m_f_cell;                      //WHICH AN OFFSET OF CELL FACES
	double        *dist_pncorr;                                 //Orthogonal correction.
                                                        //This is the dist_pn projection to normal direction
                                                        //Is vec_pn*


	double *m_vec_pf_LR;				//Distancia del baricentro del cell al de la cara
	double *m_vec_normal_LR;		//Vector normalizado y su opuesto, el primero apunta P-L y el otro hacia el vecino N-R
  double *m_Af;               //Face Area

	double *f_pn;                           //factor de interpolación a ambos lados
  //std::vector <Cell_CC> *pcell;                       //Puntero a cells



}; //DOMAIN_d


};

#endif
