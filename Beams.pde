class beams{
 int index = 0;
 pt[][] points = new pt[16000][2];
 pt[][][] sampleCircle = new pt [100][10000][6];
 int sampleIndex = 0;
 beams(){}
 void clear() {index = 0;}
 void insertBeam(pt A, pt B){
   //println(contains(A,B));
   if(contains(A,B)){
     points[index][0] = A;
     points[index][1] = B;
     index ++;
   }
 }
 
 boolean contains (pt A, pt B){
   for(int i=0; i<index; i++)  {
     if((A==points[i][0] && B==points[i][1])||(B==points[i][0] && A==points[i][1]))
       return false;
   }
   return true;
 }
 
 void drawBeams(){
   for(int i=0; i<index; i++)  {
     beam(points[i][0], points[i][1], rt);  
   }
 }
 
 void sampleBeam(){
    for(int i=0; i<index; i++){//current beam number
      pt A = points[i][0];
      pt B = points[i][1];
      vec K = U(V(A,B));
      vec I = V(-K.y,K.x,0);
      vec J = cross(K,I);
      float da = 2*PI/6;
      float as = 0;
      float dk = sqrt(3) * PI * rt / 6;
      int j=-1;//current circle number
      for(float k=0; k<d(A,B); k+=dk){
        j++;
        int l=-1; //samples in one circle
        for(float a=as; a<2*PI+as-0.5*da; a+=da){
          l++;
          sampleCircle[i][j][l] = P(A,rt*cos(a),I,rt*sin(a),J,k,K);
          fill(black);
          show(sampleCircle[i][j][l],2);
        }
        as+=0.5*da;
        if(as>=2*PI) as = 0.5*da;
      }
      
    }
 }
}