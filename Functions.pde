import java.util.Map;
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
  normalOfTraignle = U(cross(V(A,B), V(A,C)));
  
  float v = sqrt(pow(r,2) - pow(d(centerOfTriangle,A),2));
  centerOfSphere = P(centerOfTriangle, v, normalOfTraignle);
  //beam(centerOfTriangle, centerOfSphere,rt ); 
  if(show)show(centerOfSphere,r);
  return centerOfSphere;
}

int findCandidateTriangle(pts P, int a, int b, pt Center, float r,boolean show)
{
  pt A = P.G[a];
  pt B = P.G[b];
  float maxAngle = 2*PI;
  pt midAB = P(A,B);
  pt centerResult = null;
  pt centerResultTri = null;
  int C = 0;
  for(int i=0; i<P.nv; i++)
  {

    pt centerOfTriangle = findCircumCenter(P.G[i], A, B);
    if(d(P.G[i],A)<0.01) continue;
    if(d(P.G[i],B)<0.01) continue;
    if(boarderCount[i]<=0 && P.seen[i]) continue;
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
   //println(i+" angle "+ angle);
   if(angle < maxAngle)
   {
     maxAngle = angle; 
     centerResult = centerOfSphere;
     centerResultTri = centerOfTriangle;
     C = i;
   }
   
  }
  //fill(blue,30);
  //beam(centerResultTri, centerResult,rt ); 
  //show(centerResultTri,20);
  if(show && centerResult!=null)show(centerResult,r);
  return C;
}

void sampleSphere(pts P, pt[] samples)
{
  for(int i=0; i<P.nv; i++){
    /*
    fill(black);
    samples[samplePointsIndex] = P(P.G[i], rt, V(0,0,1));samplePointsIndex++;
    samples[samplePointsIndex] = P(P.G[i], rt, V(0,0,-1));samplePointsIndex++;
    samples[samplePointsIndex] = P(P.G[i], rt, V(0,1,0));samplePointsIndex++;
    samples[samplePointsIndex] = P(P.G[i], rt, V(0,-1,0));samplePointsIndex++;
    samples[samplePointsIndex] = P(P.G[i], rt, V(1,0,0));samplePointsIndex++;
    samples[samplePointsIndex] = P(P.G[i], rt, V(-1,0,0));samplePointsIndex++;
    triangle sphereTriangle = new triangle();
    sphereTriangle.insertTriangle(P(P.G[i], rt, V(1,0,0)),P(P.G[i], rt, V(0,1,0)),P(P.G[i], rt, V(0,0,1)));
    sphereTriangle.insertTriangle(P(P.G[i], rt, V(1,0,0)),P(P.G[i], rt, V(0,1,0)),P(P.G[i], rt, V(0,0,-1)));
    sphereTriangle.insertTriangle(P(P.G[i], rt, V(1,0,0)),P(P.G[i], rt, V(0,-1,0)),P(P.G[i], rt, V(0,0,1)));
    sphereTriangle.insertTriangle(P(P.G[i], rt, V(1,0,0)),P(P.G[i], rt, V(0,-1,0)),P(P.G[i], rt, V(0,0,-1)));
    sphereTriangle.insertTriangle(P(P.G[i], rt, V(-1,0,0)),P(P.G[i], rt, V(0,1,0)),P(P.G[i], rt, V(0,0,1)));
    sphereTriangle.insertTriangle(P(P.G[i], rt, V(-1,0,0)),P(P.G[i], rt, V(0,1,0)),P(P.G[i], rt, V(0,0,-1)));
    sphereTriangle.insertTriangle(P(P.G[i], rt, V(-1,0,0)),P(P.G[i], rt, V(0,-1,0)),P(P.G[i], rt, V(0,0,1)));
    sphereTriangle.insertTriangle(P(P.G[i], rt, V(-1,0,0)),P(P.G[i], rt, V(0,-1,0)),P(P.G[i], rt, V(0,0,-1)));
    sphereTriangle.divideTriangle(P.G[i],samples);
    //sphereTriangle.divideTriangle(P.G[i],samples);
    //sphereTriangle.showPoints();
    //samplePoints.addPt(P(P.G[i], rt, V(0,0,1)));
    //samplePoints.addPt(P(P.G[i], rt, V(0,0,-1)));
    //samplePoints.addPt(P(P.G[i], rt, V(0,1,0)));
    //samplePoints.addPt(P(P.G[i], rt, V(0,-1,0)));
    //samplePoints.addPt(P(P.G[i], rt, V(1,0,0)));
    //samplePoints.addPt(P(P.G[i], rt, V(-1,0,0)));
    */
    vec I = V(1,0,0), J = V(0,1,0), K = V(0,0,1);
    pt center = P.G[i];
    /*
    float a = 0, sa = 2 * PI / 16;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, V(sin(a), J, cos(a), I)));  
    }
    sa = 2 * PI / 12;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(PI/8) * sin(a), J, cos(PI/8) * cos(a), I, sin(PI/8), K))));  
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(PI/8) * sin(a), J, cos(PI/8) * cos(a), I, -sin(PI/8), K))));  
    }
    sa = 2 * PI / 8;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(PI/4) * sin(a), J, cos(PI/4) * cos(a), I, sin(PI/4), K))));  
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(PI/4) * sin(a), J, cos(PI/4) * cos(a), I, -sin(PI/4), K))));  
    }
    sa = 2 * PI / 4;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(3*PI/8) * sin(a), J, cos(3*PI/8) * cos(a), I, sin(3*PI/8), K))));  
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(3*PI/8) * sin(a), J, cos(3*PI/8) * cos(a), I, -sin(3*PI/8), K))));  
    }
      samplePoints.addPt((P(P.G[i],rt,K)));
      
      samplePoints.addPt((P(P.G[i],-rt,K)));*/
      
    float a = 0, sa = 2 * PI / 24;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, V(sin(a), J, cos(a), I)));  
    }
    sa = 2 * PI / 21;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(PI/8/2) * sin(a), J, cos(PI/8/2) * cos(a), I, sin(PI/8/2), K))));  
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(PI/8/2) * sin(a), J, cos(PI/8/2) * cos(a), I, -sin(PI/8/2), K))));  
    }
    sa = 2 * PI / 18;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(PI/8) * sin(a), J, cos(PI/8) * cos(a), I, sin(PI/8), K))));  
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(PI/8) * sin(a), J, cos(PI/8) * cos(a), I, -sin(PI/8), K))));  
    }
    sa = 2 * PI / 15;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(3*PI/16) * sin(a), J, cos(3*PI/16) * cos(a), I, sin(3*PI/16), K))));  
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(3*PI/16) * sin(a), J, cos(3*PI/16) * cos(a), I, -sin(3*PI/16), K))));  
    }
    sa = 2 * PI / 12;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(PI/4) * sin(a), J, cos(PI/4) * cos(a), I, sin(PI/4), K))));  
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(PI/4) * sin(a), J, cos(PI/4) * cos(a), I, -sin(PI/4), K))));  
    }
    sa = 2 * PI / 9;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(5*PI/16) * sin(a), J, cos(5*PI/16) * cos(a), I, sin(5*PI/16), K))));  
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(5*PI/16) * sin(a), J, cos(5*PI/16) * cos(a), I, -sin(5*PI/16), K))));  
    }
    sa = 2 * PI / 6;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(3*PI/8) * sin(a), J, cos(3*PI/8) * cos(a), I, sin(3*PI/8), K))));  
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(3*PI/8) * sin(a), J, cos(3*PI/8) * cos(a), I, -sin(3*PI/8), K))));  
    }
    sa = 2 * PI / 3;
    for(a = 0; a<2*PI-0.5*sa; a+=sa)
    {
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(7*PI/16) * sin(a), J, cos(7*PI/16) * cos(a), I, sin(7*PI/16), K))));  
      samplePoints.addPt(P(P.G[i], rt, U(V(cos(7*PI/16) * sin(a), J, cos(7*PI/16) * cos(a), I, -sin(7*PI/16), K))));  
    }
      samplePoints.addPt((P(P.G[i],rt,K)));
      
      samplePoints.addPt((P(P.G[i],-rt,K)));
  }
}

pt pushToSphere(pt center, pt P)
{
   vec V = U(V(center,P));
   pt G = P(center,rt,V);
   return G;
}

Long getKey(int A, int B)
{
  if(A<B) return (long)A*100000+B;
  else return (long)B*100000+A;
}

int[] findFirst(pts P, HashMap<Long,Long> hm, int A, int B, int C)
{
  int[] result = new int[3];
  vec cross = cross(V(P.G[A],P.G[B]),V(P.G[A],P.G[C]));
  P.seen[A] = true;P.seen[B] = true;P.seen[C] = true;
  hm.put(getKey(A,B),getKey(A,B));boarderCount[A]++;boarderCount[B]++;
  hm.put(getKey(A,C),getKey(A,C));boarderCount[A]++;boarderCount[C]++;
  hm.put(getKey(B,C),getKey(B,C));boarderCount[B]++;boarderCount[C]++;
  //for (Map.Entry me : hm.entrySet()) {
  //print(me.getKey() + " is ");
  //println(me.getValue());
  //}
  //dot(cross,V(center,P.G[A]))>0
  float radius = 30;
  fill(cyan,50);
  pt ballCenter = findCenter3Points(P.G[A],P.G[B],P.G[C],radius,false);
  pt circumCenter = findCircumCenter(P.G[A],P.G[B],P.G[C]);
  fill(orange,50);
  //println(dot(U(V(P.G[A],P.G[B])),U(cross(V(P.G[C],ballCenter),V(circumCenter,ballCenter)))));
  if(dot(U(V(P.G[A],P.G[B])),U(cross(V(P.G[C],ballCenter),V(circumCenter,ballCenter))))>0)
    {
      int D = findCandidateTriangle(P,A,B,ballCenter, radius, false);
      result[0] = A; result[1] = B; result[2] = D;
    }
  else
    {
      int D = findCandidateTriangle(P,B,A,ballCenter, radius, false);
      result[0] = B; result[1] = A; result[2] = D;
    }
  fill(red);show(P.G[A],P.G[B],P.G[C]);
  //fill(green);show(P.G[result[0]],P.G[result[1]],P.G[result[2]]);
  return result;
}

int[] findPath(pts P, HashMap<Long,Long> hm, int[] currentTri)
{
  int A = currentTri[0]; int B = currentTri[1]; int C = currentTri[2]; 
  show(P.G[A],P.G[B],P.G[C]);
  int [] result = new int[3];
  float radius = 20;
  //fill(cyan,50);
  pt ballCenter = findCenter3Points(P.G[A],P.G[B],P.G[C],radius,false);
  pt circumCenter = findCircumCenter(P.G[A],P.G[B],P.G[C]);
  int [] choose = new int[2];
  int unChoose = 0;
  //println(P.seen[C]);
  if(!P.seen[C]) 
  {
    choose[0] = A; choose[1] = C; unChoose = B;P.seen[C]=true;
  }
  else if(P.seen[C])
  {
    if(!hm.keySet().contains(getKey(A,C)) && !hm.keySet().contains(getKey(B,C)))
    {
      int[] temp = {C,B,A};
      remaining.push(temp);
      choose[0] = A; choose[1] = C; unChoose = B;
    }
    else if (hm.keySet().contains(getKey(A,C)) && !hm.keySet().contains(getKey(B,C)))
    {
      choose[0] = C; choose[1] = B; unChoose = A;
    }
    else if (!hm.keySet().contains(getKey(A,C)) && hm.keySet().contains(getKey(B,C)))
    {
      choose[0] = A; choose[1] = C; unChoose = B;
    }
    else
    {
      if(remaining.empty()) return null;
      else
      {
        int[] temp = remaining.pop();
        while(!hm.keySet().contains(getKey(temp[0],temp[1])) && !remaining.empty()) temp = remaining.pop();
        if(remaining.empty()) return null;
        choose[0] = temp[0]; choose[1] = temp[1]; unChoose = temp[2];
      }
    }
  }
      //fill(orange,50);
    //if(dot(U(V(P.G[choose[0]],P.G[choose[1]])),U(cross(V(P.G[unChoose],ballCenter),V(circumCenter,ballCenter))))>0)
    //  {
        int D = findCandidateTriangle(P,choose[0],choose[1],ballCenter, radius, false);
        result[0] = choose[0]; result[1] = choose[1]; result[2] = D;
    //  }
    //else
    //  {
    //    int D = findCandidateTriangle(P,P.G[choose[1]],P.G[choose[0]],ballCenter, radius, false);
    //    result[0] = choose[1]; result[1] = choose[0]; result[2] = D;
    //  }
      
  if(hm.keySet().contains(getKey(A,B))) {hm.remove(getKey(A,B));boarderCount[A]--;boarderCount[B]--;}
  else {hm.put((getKey(A,B)),(getKey(A,B)));boarderCount[A]++;boarderCount[B]++;}
  if(hm.keySet().contains(getKey(A,C))) {hm.remove(getKey(A,C));boarderCount[A]--;boarderCount[C]--;}
  else {hm.put((getKey(A,C)),(getKey(A,C)));boarderCount[A]++;boarderCount[C]++;}
  if(hm.keySet().contains(getKey(B,C))) {hm.remove(getKey(B,C));boarderCount[B]--;boarderCount[C]--;}
  else {hm.put((getKey(B,C)),(getKey(B,C)));boarderCount[B]++;boarderCount[C]++;}
  //show(P.G[result[0]],P.G[result[1]],P.G[result[2]]);
  return result;
}



int[] findPathb(pts P, HashMap<Long,Long> hm, int[] currentTri)
{
  
  int A = currentTri[0]; int B = currentTri[1]; int C = currentTri[2]; 
  show(P.G[A],P.G[B],P.G[C]);
  int [] result = new int[3];
  float radius = 20;
  //fill(cyan,50);
  pt ballCenter = findCenter3Points(P.G[A],P.G[B],P.G[C],radius,false);
  pt circumCenter = findCircumCenter(P.G[A],P.G[B],P.G[C]);
  int [] choose = new int[2];
  int unChoose = 0;
  //println(P.seen[C]);
  if(!P.seen[C]) 
  {
    choose[0] = A; choose[1] = C; unChoose = B;P.seen[C]=true;
  }
  else if(P.seen[C])
  {
    if(!hm.keySet().contains(getKey(A,C)) && !hm.keySet().contains(getKey(B,C)))
    {
      int[] temp = {C,B,A};
      remaining.push(temp);
      choose[0] = A; choose[1] = C; unChoose = B;
    }
    else if (hm.keySet().contains(getKey(A,C)) && !hm.keySet().contains(getKey(B,C)))
    {
      choose[0] = C; choose[1] = B; unChoose = A;
    }
    else if (!hm.keySet().contains(getKey(A,C)) && hm.keySet().contains(getKey(B,C)))
    {
      choose[0] = A; choose[1] = C; unChoose = B;
    }
    else
    {
      if(remaining.empty()) return null;
      else
      {
        int[] temp = remaining.pop();
        while(!hm.keySet().contains(getKey(temp[0],temp[1])) && !remaining.empty()) temp = remaining.pop();
        if(remaining.empty()) return null;
        choose[0] = temp[0]; choose[1] = temp[1]; unChoose = temp[2];
      }
    }
  }
      //fill(orange,50);
    //if(dot(U(V(P.G[choose[0]],P.G[choose[1]])),U(cross(V(P.G[unChoose],ballCenter),V(circumCenter,ballCenter))))>0)
    //  {
        int D = findCandidateTriangle(P,choose[0],choose[1],ballCenter, radius, true);
        result[0] = choose[0]; result[1] = choose[1]; result[2] = D;
    //  }
    //else
    //  {
    //    int D = findCandidateTriangle(P,P.G[choose[1]],P.G[choose[0]],ballCenter, radius, false);
    //    result[0] = choose[1]; result[1] = choose[0]; result[2] = D;
    //  }
      
  if(hm.keySet().contains(getKey(A,B))) {hm.remove(getKey(A,B));boarderCount[A]--;boarderCount[B]--;}
  else {hm.put((getKey(A,B)),(getKey(A,B)));boarderCount[A]++;boarderCount[B]++;}
  if(hm.keySet().contains(getKey(A,C))) {hm.remove(getKey(A,C));boarderCount[A]--;boarderCount[C]--;}
  else {hm.put((getKey(A,C)),(getKey(A,C)));boarderCount[A]++;boarderCount[C]++;}
  if(hm.keySet().contains(getKey(B,C))) {hm.remove(getKey(B,C));boarderCount[B]--;boarderCount[C]--;}
  else {hm.put((getKey(B,C)),(getKey(B,C)));boarderCount[B]++;boarderCount[C]++;}
  //show(P.G[result[0]],P.G[result[1]],P.G[result[2]]);
  return result;
}