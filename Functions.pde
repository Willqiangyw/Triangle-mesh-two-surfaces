void findTriangles(pts A, triangle T) {
  for (int i=0; i<A.nv; i++) {
    for (int j=i+1; j<A.nv; j++) {
      for (int k=j+1; k<A.nv; k++) {
        pt center = findCircumCenter(A.G[i], A.G[j], A.G[k]);
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



pt findCircumCenter(pt A, pt B, pt C){
  pt circumCenter;
  pt midPtAB = P(A, B);
  pt midPtAC = P(A, C);
  
 // vec BA = V(B, A);
  vec AB = V(A, B);
  vec AC = V(A, C);
  vec A_midPtAB  = V(A, midPtAB);
  vec A_midPtAC  = V(A, midPtAC);
  pt projection = P(A,dot(AC,U(AB)),U(AB));
  vec orthognalAB = U(V(projection, C));
 // vec orthognalAB = R(AB,90,U(V(A,B)),U(V(A,C)));
  float s = 0.0;
  s =  (dot(A_midPtAC, A_midPtAC) - dot(A_midPtAB ,A_midPtAC)) / (dot(orthognalAB ,A_midPtAC));
  circumCenter =midPtAB. add(orthognalAB. mul(s));
  //show(circumCenter,50);
  return circumCenter;
 
}  

float findBuldge (pt A, pt B, pt C, pt D, boolean show) {
  float buldge = 0.0;
  pt centerOfTriangle = findCircumCenter(A, B, C);
 // show(centerOfTriangle, 50);
  vec normalOfTraignle;
  if(det2 (V(A,B), V(A,C)) <0 ) { // NORMAL DOWNWARD
     normalOfTraignle = U(cross(V(A,C), V(A,B)));
  } 
  else { // NORMAL UPWARD
    normalOfTraignle = U(cross(V(A,B), V(A,C)));
  }
  
  vec DA = U(V(D,A));
  float magnitude = (dot(V(centerOfTriangle ,A), DA) - dot(V(D, centerOfTriangle), DA)) / (2* (dot(normalOfTraignle, DA)));
  pt centerOfSphere = P(centerOfTriangle,magnitude,normalOfTraignle);
  float radiusOfSphere = d(A,centerOfSphere);
  buldge = radiusOfSphere + d(centerOfSphere, centerOfTriangle);
  //pt upNode = P(centerOfTriangle,buldge,normalOfTraignle);
  //vec test = V(centerOfTriangle, upNode);
 // println(magnitude);
 // buldge = radiusOfSphere + 
 // show(centerOfSphere, 50);
  
  //println(n(normalOfTraignle));
  //vec test = V(100,normalOfTraignle);
  

  //beam(centerOfTriangle, upNode,rt ); 
 // beam(centerOfTriangle,P(centerOfTriangle,test),rt);
 if(show)show(centerOfSphere,radiusOfSphere);
 return buldge;
}

//pt[] find(pts Q, pts P){
//  pt[] floorAndCeiling = new pt[4];
//  for (int i=0; i<Q.nv; i++){
//    pt A = Q.G[i];
//    pt B = Q.G[i+1];
//    for (int j = 0; j < P.nv; j++){
//        pt C = P.G[i];
//        pt D = P.G[i+1];
//        findBuldge (A,  B, C, D, true);
   
//    }
    
//  }

void findTwoByTwo(beams ceilingBeam, beams floorBeam, beams intervalBeam){
  //pt[] floorAndCeiling = new pt[4];
  for (int i=0; i<ceilingBeam.index; i++){
    pt A = ceilingBeam.points[i][0];
    pt B = ceilingBeam.points[i][1];   
    for (int j = 0; j <floorBeam.index; j++){
        pt C = floorBeam.points[j][0];
        pt D = floorBeam.points[j][1];
        pt center = findCenter(A,  B,  C,  D,  false);
        boolean good = true;
        for (int k =0; k < P.nv; k++) {
          if(P.G[k] == A || P.G[k] == B || P.G[k] == C || P.G[k] == D){
            continue;
          }
         if(d(center, P.G[k]) <= d(center,A)){
           good = false;
           break;
         } 
        }
        
        for (int k =0; k < Q.nv; k++) {
          if(Q.G[k] == A || Q.G[k] == B || Q.G[k] == C || Q.G[k] == D){
            continue;
          }
         if(d(center, Q.G[k]) <= d(center,A)){
           good = false;
           break;
         } 
        }
        
        if(good) {
         intervalBeam.insertBeam(A, C);
         intervalBeam.insertBeam(A, D);
         intervalBeam.insertBeam(B, C);
         intervalBeam.insertBeam(B, D); 
         tetCount++;
        }
    }   
  }
}



pt findCenter (pt A, pt B, pt C, pt D, boolean show) {
  float buldge = 0.0;
  pt centerOfTriangle = findCircumCenter(A, B, C);
 // show(centerOfTriangle, 50);
  vec normalOfTraignle;
  if(det2 (V(A,B), V(A,C)) <0 ) { // NORMAL DOWNWARD
     normalOfTraignle = U(cross(V(A,C), V(A,B)));
  } 
  else { // NORMAL UPWARD
    normalOfTraignle = U(cross(V(A,B), V(A,C)));
  }
  
  vec DA = U(V(D,A));
  float magnitude = (dot(V(centerOfTriangle ,A), DA) - dot(V(D, centerOfTriangle), DA)) / (2* (dot(normalOfTraignle, DA)));
  pt centerOfSphere = P(centerOfTriangle,magnitude,normalOfTraignle);
  float radiusOfSphere = d(A,centerOfSphere);
  buldge = radiusOfSphere + d(centerOfSphere, centerOfTriangle);
  //pt upNode = P(centerOfTriangle,buldge,normalOfTraignle);
  //vec test = V(centerOfTriangle, upNode);
 // println(magnitude);
 // buldge = radiusOfSphere + 
 // show(centerOfSphere, 50);
  
  //println(n(normalOfTraignle));
  //vec test = V(100,normalOfTraignle);
  

  //beam(centerOfTriangle, upNode,rt ); 
 // beam(centerOfTriangle,P(centerOfTriangle,test),rt);
 if(show)show(centerOfSphere,radiusOfSphere);
 return centerOfSphere;
}

pt findCenter3Points(pt A, pt B, pt C, float r,boolean show)
{
  
  pt centerOfSphere;
  pt centerOfTriangle = findCircumCenter(A, B, C);
  //println(d(centerOfTriangle,A));
  vec normalOfTraignle;
  normalOfTraignle = U(cross(V(A,C), V(A,B)));
  
  float v = sqrt(pow(r,2) - pow(d(centerOfTriangle,A),2));
  centerOfSphere = P(centerOfTriangle, v, normalOfTraignle);
  beam(centerOfTriangle, centerOfSphere,rt ); 
  if(show)show(centerOfSphere,r);
  return centerOfSphere;
}

void findCandidateTriangle(pt A, pt B, pt Center, float r,boolean show)
{
  float maxAngle = 2*PI;
  pt midAB = P(A,B);
  pt centerResult = null;
  for(int i=0; i<P.nv; i++)
  {

    pt centerOfTriangle = findCircumCenter(P.G[i], A, B);
    noStroke();
    //fill(red);show(A,40);
    //fill(blue);show(B,40);
    //fill(yellow);show(P.G[i],40);
    //fill(green);show(centerOfTriangle,20);
    //    fill(blue,30);
    float radiusOfTriangle = d(centerOfTriangle,A);
      //println(radiusOfTriangle);
    if (radiusOfTriangle>r) continue;
    vec normalOfTraignle = U(cross(V(A,B), V(A,P.G[i])));
    float v = sqrt(pow(r,2) - pow(d(centerOfTriangle,A),2));
    pt centerOfSphere = P(centerOfTriangle, v, normalOfTraignle);
    //show(centerOfTriangle,20);
    //beam(centerOfTriangle, centerOfSphere,rt ); 
    ////if(show)show(centerOfSphere,r);
    //fill(black);beam(midAB, centerOfSphere,rt);
    //return centerOfSphere;
   //lenSq1 = x1*x1 + x2*x2 + 
    //angle = acos(dot/sqrt(lenSq1 * lenSq2));
    
   // println(i+" angle "+atan2(norm(cross(V(midAB,Center),V(midAB,centerOfSphere))), dot(V(midAB,Center),V(midAB,centerOfSphere)))/2/PI*360);
   //println(i+" angle "+acos(dot(V(midAB,Center),V(midAB,centerOfSphere))/(n(V(midAB,Center))*n(V(midAB,centerOfSphere))))/2/PI*360);
   //println(i+" test "+dot(U(V(A,B)),U(cross(V(midAB,Center),V(midAB,centerOfSphere)))));
   float angle = acos(dot(V(midAB,Center),V(midAB,centerOfSphere))/(n(V(midAB,Center))*n(V(midAB,centerOfSphere))));
   if(dot(U(V(A,B)),U(cross(V(midAB,Center),V(midAB,centerOfSphere))))>=0)
     angle = -angle + 2*PI;
   println(i+" angle "+ angle);
   if(angle < maxAngle)
   {
     maxAngle = angle; 
     centerResult = centerOfSphere;
   }
   
  }
  fill(blue,30);
  if(show && centerResult!=null)show(centerResult,r);
}