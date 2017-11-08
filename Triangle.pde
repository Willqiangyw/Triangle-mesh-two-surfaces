class triangle{
  pt[] triangles = new pt[16000*3];
  int index=0;
  triangle()  {}
  void clear() {index = 0;}
  void insertTriangle(pt A, pt B, pt C) {
   triangles[index] = A; index++;
   triangles[index] = B; index++;
   triangles[index] = C; index++;
  }
  void checkTriangle(){
    for (int i=0; i<index; i=i+3)
    {
      beam(triangles[i],triangles[i+1],rt);
      beam(triangles[i+1],triangles[i+2],rt);
      beam(triangles[i+2],triangles[i],rt);
    }
  }
}