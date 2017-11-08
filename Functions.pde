void findTriangles(pts A, triangle T) {
  for (int i=0; i<A.nv; i++) {
    for (int j=i+1; j<A.nv; j++) {
      for (int k=j+1; k<A.nv; k++) {
        pt center = circumCenter(A.G[i], A.G[j], A.G[k]);
        float radius = d(center, A.G[i]);
        boolean good = true;
        for (int m=0; m<A.nv; m++) {
          if (m!=i && m!=j &&m!=k) {
            if (d(center, A.G[m])<radius)
              good = false;
          }
        }
        if (good) {
          T.insertTriangle(A.G[i], A.G[j], A.G[k]);
        }
      }
    }
  }
}

pt circumCenter(pt A, pt B, pt C) {
  pt center;

  return center;
}