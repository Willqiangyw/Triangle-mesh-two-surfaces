class beams{
 int index = 0;
 pt[][] points = new pt[16000][2];
 beams(pt A, pt B){
   points[index][0] = A;
   points[index][1] = B;
   index ++;
 }
}