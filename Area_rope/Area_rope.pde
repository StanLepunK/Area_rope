PImage img ;
void setup() {
  size(800,600) ;
  img = loadImage("pirate.jpg") ;
  // img = loadImage("purosGirl.jpg") ;
  
  surface.setSize(img.width, img.height) ;
  
  bitmap_set_analyze() ;
  int step_x = 10 ;
  int step_y = 10 ;
  bitmap_analyze(img, step_x, step_y) ;
  
   
}

void draw() {

  
  background(0) ;
  for(Vec3 v : pix_list) {
    Vec2 pos = Vec2(v.x, v.y) ;
    int c = (int)v.z;
    stroke(red(c), green(c), blue(c)) ;
    // stroke(c) ;
    // stroke(0) ;
    strokeWeight(10) ;
    point(pos) ;
  } 
  
}



