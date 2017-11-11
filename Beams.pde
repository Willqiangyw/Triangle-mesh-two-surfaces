class beams{
 int index = 0;
 pt[][] points = new pt[16000][2];
 beams(){}
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
}