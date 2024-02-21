
namespace FVM{
Domain_d::SetDimension(const int &nc, const int &cc, const int &fc){
  
  m_node_count = nc;
  m_cell_count = cc;
  m_face_count = fc;
  
  //// CELL ALLOCATION
  cudaMalloc((void **)&c_PK,            m_cell_count * 6 * sizeof (double)); // PIOLA  KIRCHOFF
  cudaMalloc((void **)&m_c_face_count,  m_cell_count * sizeof (unsigned int)); // PIOLA  KIRCHOFF
  cudaMalloc((void **)&m_c_face,        m_cell_count * 4 * sizeof (unsigned int)); // PIOLA  KIRCHOFF
// cudaMalloc((void **)&m_c_offset,      m_cell_count * sizeof (unsigned int)); // PIOLA  KIRCHOFF
  //OFSET NOT SET

  //FACE ALLOCATION
  cudaMalloc((void **)&m_Af,        m_face_count * sizeof (double)); // PIOLA  KIRCHOFF
	cudaMalloc((void **)&m_e_pn,      m_face_count * sizeof (double3));											  //Vector normalizado entre baricentros


}


void Domain_d::AddBoxLength(double3 const & V, double3 const & L, const double &r,const bool &red_int){

    double3 Xp;
    int p, nnodz;

    int nel[3];
    m_dim = 3;
    if (L.z > 0.0) m_dim = 3;
    
    
    nel[0] = (int)(L.x/(2.0*r));
    nel[1] = (int)(L.y/(2.0*r));
    cout << "Nel x: "<<nel[0]<<", y "<<nel[1]<<endl;
    
    m_gp_count = 1;
    if (m_dim == 2){
      nel[2] = 1;
      m_nodxelem = 4;
      if (!red_int) m_gp_count = 4;
    } else {
      nel[2] = (int)(L.z/(2.0*r));
      m_nodxelem = 8;
      if (!red_int) m_gp_count = 8; 
    }
    

    Xp.z = V.z ;
    

    // write (*,*) "Creating Mesh ...", "Elements ", neL.y, ", ",neL.z
  int nc = (nel[0] +1) * (nel[1]+1) * (nel[2]+1);
  int ne = nel[0]*nel[1]*nel[2];
  cout << "Mesh created. Element count: "<< nel[0]<<", "<<nel[1]<<", "<<nel[2]<<endl;
  
  //thisAllocateNodes((nel[0] +1) * (nel[1]+1) * (nel[2]+1));
    // print *, "Element count in XYZ: ", nel(:)
    // write (*,*) "Box Node count ", node_count
  //FACE CALCULATION
  unsigned int nf;
	fc =  nel[0]*nel[1]*(nel[2]+1)+
        nel[0]*nel[2]*(nel[1]+1)+
        nel[1]*nel[2]*(nel[0]+1);  
  this->SetDimension(nc,ne, fc);	 //AFTER CREATING DOMAIN

  cout << "Mesh generated. Node count: " << nc<<". Element count: "<<ne<<". Face count: "<<fc<<endl;
  cout << "Dimension is: "<<m_dim<<endl;
  //SPH::Domain	dom;
	//double3 *x =  (double3 *)malloc(dom.Particles.size());
	double3 *x_H =  new double3 [m_node_count];


	//int size = dom.Particles.size() * sizeof(double3);
	cout << "Copying to device..."<<endl;
    
    cout << "Box Particle Count is " << m_node_count <<endl;
    p = 0;
    for (int k = 0; k < (nel[2] +1);k++) {
      Xp.y = V.y;
      for (int j = 0; j < (nel[1] +1);j++){
        Xp.x = V.x;
        for (int i = 0; i < (nel[0] +1);i++){
					//m_node.push_back(new Node(Xp));
					x_H[p] = Xp;
          //nod%x(p,:) = Xp(:);
          cout << "node " << p <<"X: "<<Xp.x<<"Y: "<<Xp.y<<"Z: "<<Xp.z<<endl;
          p++;
          Xp.x = Xp.x + 2.0 * r;
        }
        Xp.y = Xp.y + 2.0 * r;
      }// 
      Xp.z = Xp.z + 2 * r;

    //cout <<"m_node size"<<m_node.size()<<endl;
    } 
		cudaMemcpy(this->x, x_H, sizeof(double3) * m_node_count, cudaMemcpyHostToDevice);    

    // !! ALLOCATE ELEMENTS
    // !! DIMENSION = 2
    int gp = 1;
    if (m_dim == 2) {
      // if (redint .eqv. .False.) then
        // gp = 4
      // end if 
      //call AllocateElements(neL.y * neL.z,gp) !!!!REDUCED INTEGRATION
    } else {
      // if (redint .eqv. .False.) then
        // gp = 8
      // end if 
      // call AllocateElements(neL.y * neL.z*nel(3),gp) 
    }

		unsigned int *elnod_h = new unsigned int [m_elem_count * m_nodxelem]; //Flattened
    
		int ex, ey, ez;
		std::vector <int> n;
    if (m_dim == 2) {
			n.resize(4);
      int ei = 0;
      for (int ey = 0; ey < nel[1];ey++){
        for (int ex = 0; ex < nel[0];ex++){
        int iv[4];
        elnod_h[ei  ] = (nel[0]+1)*ey + ex;        elnod_h[ei+1] = (nel[0]+1)*ey + ex+1;
        elnod_h[ei+2] = (nel[0]+1)*(ey+1) + ex+1;  elnod_h[ei+3] = (nel[0]+1)*(ey+1) + ex;
			
				 for (int i=0;i<m_nodxelem;i++)cout << elnod_h[ei+i]<<", ";
					cout << "Nel x : "<<nel[0]<<endl;
					cout << "nodes "<<endl;
					ei += m_nodxelem;
					 }
      } 
    } else { //dim: 3
      int ei = 0;
      int nnodz = (nel[0]+1)*(nel[1]+1);
      for (int ez = 0; ez < nel[2];ez++)
      for (int ey = 0; ey < nel[1];ey++){
        for (int ex = 0; ex < nel[0];ex++){
          
          int iv[8];
          int nb1 = nnodz*ez + (nel[0]+1)*ey + ex;
          int nb2 = nnodz*ez + (nel[0]+1)*(ey+1) + ex;
          elnod_h[ei  ] = nb1;
          elnod_h[ei+1] = nb1+1;
          elnod_h[ei+2] = nb2+1;
          elnod_h[ei+3] = nb2;
          elnod_h[ei+4] = nb1 + nnodz*(ez+1);
          elnod_h[ei+5] = nb1 + nnodz*(ez+1) + 1;
          elnod_h[ei+6] = nb2 + nnodz*(ez+1) + 1;
          elnod_h[ei+7] = nb2 + nnodz*(ez+1);
          
          for (int i=0;i<8;i++)
            cout << elnod_h[ei + i]<<", ";
          cout <<endl;

          // elem%elnod(i,:) = [ nnodz*ez + (nel(1)+1)*ey + ex+1,nnodz*ez + (nel(1)+1)*ey + ex+2, &
                              // nnodz*ez + (nel(1)+1)*(ey+1)+ex+2,nnodz*ez + (nel(1)+1)*(ey+1)+ex+1, &
                              // nnodz*(ez + 1) + (nel(1)+1)*ey + ex+1,nnodz*(ez + 1) + (nel(1)+1)*ey + ex+2, &
                              // nnodz*(ez + 1) + (nel(1)+1)*(ey+1)+ex+2,nnodz*(ez + 1)+ (nel(1)+1)*(ey+1)+ex+1];
        // cout << i[]
						// n[0]= m_node[iv[0]];
						// n[1]= m_node[(nel[0]+1)*ey + ex+1];
						// n[2]= m_node[(nel[0]+1)*(ey+1)+ex+1];
						// n[3]= m_node[(nel[0]+1)*(ey+1)+ex];
            cout << "Nel x : "<<nel[0]<<endl;
           cout << "nodes "<<endl;
           
           for (int i=0;i<m_nodxelem;i++)cout << elnod_h[ei+i]<<", ";
           ei += m_nodxelem;
						 //m_element.push_back(new El4N2DPE(n));
																							// m_node[(nel[0]+1)*ey + ex+1],
																							// m_node[(nel[0]+1)*(ey+1)+ex+1],
																							// m_node[(nel[0]+1)*(ey+1)+ex]
																							// );
              //elem%elnod(i,:)=[(neL.y+1)*ey + ex+1,(neL.y+1)*ey + ex+2,(neL.y+1)*(ey+1)+ex+2,(neL.y+1)*(ey+1)+ex+1]         
              //print *, "Element ", i , "Elnod", elem%elnod(i,:) 
					 }
      } 

		}//if dim 

    cudaMalloc((void **)&m_elnod, m_elem_count * m_nodxelem * sizeof (int));		
		cudaMemcpy(this->m_elnod, elnod_h, sizeof(unsigned int) * m_elem_count * m_nodxelem, cudaMemcpyHostToDevice);    
    
    cudaMalloc(&m_jacob,m_elem_count * sizeof(Matrix ));
    
	
		delete [] elnod_h;
}

};