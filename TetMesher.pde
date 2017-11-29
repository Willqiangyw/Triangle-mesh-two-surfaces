 import java.util.Stack;
//  ******************* LITM: Layer-Interpolating Tet Mesh, 2017 ***********************
Boolean 
  animating=true, 
  PickedFocus=false, 
  center=true, 
  track=false, 
  showViewer=false, 
  showBalls=true, 
  showControl=true, 
  showCurve=true, 
  showPath=true, 
  showKeys=true, 
  showSkater=false, 
  scene1=false,
  solidBalls=false,
  showCorrectedKeys=true,
  showQuads=true,
  showVecs=true,
  showTube=true,
  flipped = false,
  pivot = false;
float 
 h_floor=0, h_ceiling=600,  h=h_floor,
  t=0, 
  s=0,
  rb=30, rt=rb; // radius of the balls and tubes
  
int
  f=0, maxf=2*30, level=4, method=5,x=21708;//4064 7260
String SDA = "angle";
float defectAngle=0;
pts P = new pts(); // polyloop in 3D
pts Q = new pts(); // second polyloop in 3D
pts R, S; 
beams ceilingBeam = new beams();
beams floorBeam = new beams();
beams intervalBeam = new beams();
int tetCount;
pts samplePoints = new pts();
pt[] samplePointsSphere = new pt[16000];
int samplePointsIndex = 0;
Stack<int[]> remaining=new Stack<int[]>();
HashMap<Long,Long> hm = new HashMap<Long,Long>();
int[] boarderCount = new int[50000];

void setup() {
  myFace = loadImage("data/pic.jpg");  // load image from file pic.jpg in folder data *** replace that file with your pic of your own face
  textureMode(NORMAL);          
  //size(900, 900, P3D); // P3D means that we will do 3D graphics
  size(800, 800, P3D); // P3D means that we will do 3D graphics
  P.declare(); Q.declare(); // P is a polyloop in 3D: declared in pts
  //P.resetOnCircle(6,100); Q.copyFrom(P); // use this to get started if no model exists on file: move points, save to file, comment this line
  P.loadPts("data/pts");  
  Q.loadPts("data/pts2"); // loads saved models from file (comment out if they do not exist yet)
  noSmooth();
  frameRate(30);
  R=P; S=Q;
  samplePoints.declare();
  }

void draw() {
  tetCount = 0;samplePointsIndex = 0;samplePoints.declare();samplePoints.empty();remaining.clear();hm.clear();
  ceilingBeam.clear();floorBeam.clear();intervalBeam.clear();
  background(255);
  hint(ENABLE_DEPTH_TEST); 
  pushMatrix();   // to ensure that we can restore the standard view before writing on the canvas
  setView();  // see pick tab
  showFloor(h); // draws dance floor as yellow mat
  doPick(); // sets Of and axes for 3D GUI (see pick Tab)
  R.SETppToIDofVertexWithClosestScreenProjectionTo(Mouse()); // for picking (does not set P.pv)
 
    
  //fill(orange); Q.drawBalls(30);
  //fill(green); P.drawBalls(30);  
  if(showBalls) 
    {
    fill(orange); P.drawBalls(rb);
    fill(green); Q.drawBalls(rb);  
    fill(red,100); R.showPicked(rb+5); 
    }
    
  //if(showTube) 
    //{
    //fill(grey); beam(P.G[0],Q.G[0],rt);
    //fill(orange); beam(P.G[0],P.G[1],rt);
    //fill(green); beam(Q.G[0],Q.G[1],rt);
    
    
    triangle floor = new triangle();
    //beams floorBeam = new beams();
    findTriangles(P,floor);
    fill(orange,40);
    floor.checkTriangle(floorBeam);
    //floorBeam.drawBeams();
    floorBeam.sampleBeam();
    triangle ceiling = new triangle();
    findTriangles(Q,ceiling);
    fill(green,40);
    ceiling.checkTriangle(ceilingBeam);
    //ceilingBeam.drawBeams();
    ceilingBeam.sampleBeam();
    fill(cyan,40);
    findTwoByTwo(ceilingBeam, floorBeam,intervalBeam );
    floor.findIntervalBeam(Q,intervalBeam);
    ceiling.findIntervalBeam(P,intervalBeam);
    //intervalBeam.drawBeams();
    intervalBeam.sampleBeam();
    
    if(showTube) 
    {
      fill(orange);floorBeam.drawBeams();
      fill(green);ceilingBeam.drawBeams();
      fill(cyan);intervalBeam.drawBeams();
    }
    ///////////////////
    if(pivot)
    {
    sampleSphere(P,samplePointsSphere);
    //floorBeam.sampleBeam();
    sampleSphere(Q,samplePointsSphere);
    //for(int i=0; i<samplePointsIndex;i++){
    //  show(samplePointsSphere[i],2);
    //  samplePoints.addPt(samplePointsSphere[i]);
    //}
    //for(int i=0; i<samplePoints.nv;i++){
    //  fill(black);
    //  show(samplePoints.G[i],2);
    //}
    //pts test = new pts();
    //test.declare();
    //for(int i=0; i<Q.nv;i++){
    //  test.addPt(Q.G[i]);
    //}
    //for(int i=0; i<P.nv;i++){
    //  test.addPt(P.G[i]);
    //}
    //println(samplePoints.nv);
    //fill(cyan,50);
    //pt center = findCenter3Points(Q.G[1],Q.G[7],Q.G[3],800,true);
    //fill(orange,50);
    //findCandidateTriangle(test,Q.G[3],Q.G[7],center, 800, true);
    //HashMap<Integer,Integer> hm = new HashMap<Integer,Integer>();
    fill(red);
    //int [] step = findFirst(samplePoints, hm, 64, 56, 58);
    //int [] step = findFirst(samplePoints, hm, 129, 127, 125);
    //int [] step = findFirst(samplePoints, hm, 200, 201, 206);
    int [] step = findFirst(samplePoints, hm, 200, 201, 212);
    
    //int [] step = findFirst(samplePoints, hm, 400, 401, 424);
    //step = findPath(samplePoints, hm, step);
    //step = findPath(samplePoints, hm, step);
    //int p=0;
    ////while(!(step[0]==0 && step[1]==0 && step[2]==0))
    println("x" + x);
    //while (p!=x)
    //fill(red,30);
    while(step!=null  && remaining.size()<1000)
    {
      //println("while");
      //p++;
      //noFill();
      step = findPath(samplePoints, hm, step);
    }
    
    if(remaining.size()>=1000)
    {
      fill(blue);
      step = findPathb(samplePoints, hm, step);
    }
    //fill(yellow);
    //step = findPath(samplePoints, hm, step);
    //fill(green);
    //step = findPath(samplePoints, hm, step);
    //fill(blue);
    //step = findPath(samplePoints, hm, step);
    println(samplePoints.nv+" so many points");
    println(remaining.size());
    if(!remaining.empty()){
    int[] temp = remaining.pop();
    for(int i:temp){println(i);}}
    for (Map.Entry me : hm.entrySet()) {
    //print(me.getKey() + " is ");
    //println(me.getValue());
    long a = (long)me.getKey() / 100000;
    long b = (long)me.getKey() % 100000;
    //println(a + " " + b);
    fill(orange);beam(samplePoints.G[(int)a],samplePoints.G[(int)b],1);
  }
    //fill(blue,50);
    //step = findPath(samplePoints, hm, step);
    //fill(red);
    //step = findPath(samplePoints, hm, step);
    //println("done");
    //fill(red);
    //int[] step = findFirst(test, hm, 3,1,7);
    //fill(blue);int[] s2 = findPath(test, hm, step);
    //fill(orange);int[] s3 = findPath(test, hm, s2);
    //fill(yellow);int[] s4 = findPath(test, hm, s3);
    //fill(cyan);int[] s5 = findPath(test, hm, s4);
    //fill(black);int[] s6 = findPath(test, hm, s5);
    ////println(remaining.empty());
    //fill(blue);int[] s7 = findPath(test, hm, s6);
    //fill(orange);int[] s8 = findPath(test, hm, s7);
    //fill(yellow);int[] s9 = findPath(test, hm, s8);
    //fill(cyan);int[] s10 = findPath(test, hm, s9);
    //fill(black);int[] s11 = findPath(test, hm, s10);
    ////println(remaining.empty());
    //fill(blue);int[] s12 = findPath(test, hm, s11);
    //fill(orange);int[] s13 = findPath(test, hm, s12);
    //fill(yellow);int[] s14 = findPath(test, hm, s13);
    //fill(cyan);int[] s15 = findPath(test, hm, s14);
    //fill(black);int[] s16 = findPath(test, hm, s15);
    ////println(remaining.empty());
    
    //fill(blue);int[] s17 = findPath(test, hm, s16);
    //fill(orange);int[] s18 = findPath(test, hm, s17);
    //fill(yellow);int[] s19 = findPath(test, hm, s18);
    //fill(cyan);int[] s20 = findPath(test, hm, s19);
    //fill(black);int[] s21 = findPath(test, hm, s20);
    ////println(remaining.empty());
    //fill(blue);int[] s22 = findPath(test, hm, s21);
    //fill(orange);int[] s23 = findPath(test, hm, s22);
    //fill(yellow);int[] s24 = findPath(test, hm, s23);
    //fill(cyan);int[] s25 = findPath(test, hm, s24);
    //fill(black);int[] s26 = findPath(test, hm, s25);
    ////println(remaining.empty());
    //fill(blue);int[] s27 = findPath(test, hm, s26);
    //fill(orange);int[] s28 = findPath(test, hm, s27);
    //fill(yellow);int[] s29 = findPath(test, hm, s28);
    //fill(cyan);int[] s30 = findPath(test, hm, s29);
    //fill(black);int[] s31 = findPath(test, hm, s30);
    ////println(remaining.empty());
    //fill(blue);int[] s32 = findPath(test, hm, s31);
    ////println(remaining.empty());
    ////println(remaining.size());
    //fill(red);int[] s33 = findPath(test, hm, s32);
    ////println(remaining.empty());
    ////println(remaining.size());
    //fill(yellow);int[] s34 = findPath(test, hm, s33);
    ////println(remaining.empty());
    //fill(cyan);int[] s35 = findPathb(test, hm, s34);
    ////println(s35 == null);
    ////println(remaining.size());
    
    //fill(black);int[] s36 = findPathb(test, hm, s35);
    //println(s36 == null);
    //fill(blue);int[] s37 = findPathb(test, hm, s36);
    //println(remaining.empty());
    //println(s35[0]+" "+s35[1]+" "+s35[2]+" ");
    //while(step!=null)
    //{
    //  step = findPath(test, hm, step);
    //}
    //}
  }
  
  popMatrix(); // done with 3D drawing. Restore front view for writing text on canvas
  hint(DISABLE_DEPTH_TEST); // no z-buffer test to ensure that help text is visible

  //*** TEAM: please fix these so that they provice the correct counts
  scribeHeader("Site count: "+P.nv+" floor + "+Q.nv+" ceiling",1);
  scribeHeader("Beam count: "+floorBeam.index+" floor + "+ceilingBeam.index+" ceiling +"+intervalBeam.index+" mixed",2);
  scribeHeader("Tet count: "+ tetCount ,3);
 
  // used for demos to show red circle when mouse/key is pressed and what key (disk may be hidden by the 3D model)
  if(mousePressed) {stroke(cyan); strokeWeight(3); noFill(); ellipse(mouseX,mouseY,20,20); strokeWeight(1);}
  if(keyPressed) {stroke(red); fill(white); ellipse(mouseX+14,mouseY+20,26,26); fill(red); text(key,mouseX-5+14,mouseY+4+20); strokeWeight(1); }
  if(scribeText) {fill(black); displayHeader();} // dispalys header on canvas, including my face
  if(scribeText && !filming) displayFooter(); // shows menu at bottom, only if not filming
  if(filming && (animating || change)) saveFrame("FRAMES/F"+nf(frameCounter++,4)+".tif");  // save next frame to make a movie
  change=false; // to avoid capturing frames when nothing happens (change is set uppn action)
  change=true;
  }