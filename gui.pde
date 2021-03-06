void keyPressed() 
  {
//  if(key=='`') picking=true; 
  if(key=='p') R.perturb(1);
  if(key=='P') R.perturb(200);
  if(key=='?') scribeText=!scribeText;
  if(key=='!') snapPicture();
  if(key=='~') filming=!filming;
  if(key=='.') showBalls=!showBalls;
  if(key=='\\') {showTube=!showTube;} // toggle showing th etubes
  if(key=='f') {flipped=!flipped; if(flipped) {R=Q; S=P; h=h_ceiling;} else {R=P; S=Q; h=h_floor;}}
  if(key=='3') {R.resetOnCircle(3,300); }
  if(key=='4') {R.resetOnCircle(4,400); }
  if(key=='5') {R.resetOnCircle(5,500); }
  if(key=='h') rt=rb/2;
  if(key=='H') rt=rb;
  if(key=='q') Q.copyFrom(P);
  if(key=='d') {R.set_pv_to_pp(); R.deletePicked();}
  if(key=='W') {P.savePts("data/pts"); Q.savePts("data/pts2");}  // save vertices to pts2
  if(key=='L') {P.loadPts("data/pts"); Q.loadPts("data/pts2");}   // loads saved model
  if(key=='w') P.savePts("data/pts");   // save vertices to pts
  if(key=='l') P.loadPts("data/pts"); 
  if(key=='a') {animating=!animating; }// toggle animation
  if(key=='|') {P.setZ(h_floor); Q.setZ(h_ceiling);} // project all sites on their respective plane
  if(key=='#') exit();
  if(key=='b') {pivot=!pivot;}
  if(key=='x') {x++;}
  if(key=='X') {x--;}
  if(key=='c') {x+=10;}
  if(key=='C') {x-=10;}
  if(key=='v') {x+=100;}
  if(key=='V') {x-=100;}
  if(key=='z') {x+=1000;}
  if(key=='Z') {x-=1000;}
  change=true;   // to save a frame for the movie when user pressed a key 
  }

void mouseWheel(MouseEvent event) 
  {
  dz -= event.getAmount(); 
  change=true;
  }

void mousePressed() 
  {
  //if (!keyPressed) picking=true;
  if (!keyPressed) {R.set_pv_to_pp(); println("picked vertex "+R.pp);}
  if(keyPressed && key=='a') {R.addPt(Of);}
//  if(keyPressed && (key=='f' || key=='s' || key=='b' || key=='c')) {P.addPt(Of,key);}

 // if (!keyPressed) P.setPicked();
  change=true;
  }
  
void mouseMoved() 
  {
  //if (!keyPressed) 
  if (keyPressed && key==' ') {rx-=PI*(mouseY-pmouseY)/height; ry+=PI*(mouseX-pmouseX)/width;};
  if (keyPressed && key=='`') dz+=(float)(mouseY-pmouseY); // approach view (same as wheel)
  change=true;
  }
  
void mouseDragged() 
  {
  if (!keyPressed) R.setPickedTo(Of); 
//  if (!keyPressed) {Of.add(ToIJ(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); }
  if (keyPressed && key==CODED && keyCode==SHIFT) {Of.add(ToK(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0)));};
  if (keyPressed && key=='x') R.movePicked(ToIJ(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
  if (keyPressed && key=='z') R.movePicked(ToK(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
  if (keyPressed && key=='X') R.moveAll(ToIJ(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
  if (keyPressed && key=='Z') R.moveAll(ToK(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
  if (keyPressed && key=='t')  // move focus point on plane
    {
    if(center) F.sub(ToIJ(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
    else F.add(ToIJ(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
    }
  if (keyPressed && key=='T')  // move focus point vertically
    {
    if(center) F.sub(ToK(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
    else F.add(ToK(V((float)(mouseX-pmouseX),(float)(mouseY-pmouseY),0))); 
    }
  change=true;
  }  

// **** Header, footer, help text on canvas
void displayHeader()  // Displays title and authors face on screen
    {
    scribeHeader(title,0); scribeHeaderRight(name); 
    fill(white); image(myFace, width-myFace.width/2,25,myFace.width/2,myFace.height/2); 
    }
void displayFooter()  // Displays help text at the bottom
    {
    scribeFooter(guide,1); 
    scribeFooter(menu,0); 
    }

String title ="Lattice Maker", name ="TEAM NAMES",
       menu="?:help, t/T:move view, space:rotate view, `/wheel:zoom, !:picture, ~:(start/stop) filming,  #:quit",
       guide="click&drag:pick&slide, f:flip ceiling/floor, .:flip show Points, b: flip show triangle mesh, \\: flip show tubes"; // user's guide