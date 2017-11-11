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
  void checkTriangle(beams b){
    for (int i=0; i<index; i=i+3)
    {
      //beam(triangles[i],triangles[i+1],rt);
      //beam(triangles[i+1],triangles[i+2],rt);
      //beam(triangles[i+2],triangles[i],rt);
      b.insertBeam(triangles[i],triangles[i+1]);      
      b.insertBeam(triangles[i+1],triangles[i+2]);
      b.insertBeam(triangles[i+2],triangles[i]);
      tetCount++;
    }
  }
  
  void findIntervalBeam(pts D,beams b){
    for  (int i=0; i<index; i=i+3){
      float min = 1000000;
      pt closest = D.G[0];
      for (int j=0; j<D.nv; j++){
        float bulge = findBuldge(triangles[i],triangles[i+1],triangles[i+2],D.G[j],false);
        if(bulge < min){
          min = bulge;
          closest = D.G[j];
        }
      }
      b.insertBeam(triangles[i],closest);      
      b.insertBeam(triangles[i+1],closest);
      b.insertBeam(triangles[i+2],closest);
      //findBuldge(triangles[i],triangles[i+1],triangles[i+2],closest,true);
    }
  }
}