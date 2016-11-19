PImage img ;
Area area ;
void setup() {
  size(800,600) ;
  img = loadImage("pirate.jpg") ;
  // img = loadImage("purosGirl.jpg") ;
  
  surface.setSize(img.width, img.height) ;
  
  int step = 5 ; 
  int bags = 3 ;
  area = new Area(img, step, bags, BRIGHTNESS_SORT) ;
  println(area.size()) ;

  

  // set_classic_grid_img(img) ;
   
}

void draw() {

  
  background(0) ;
  // classic_grid_img() ; 
  
}


// CLASSIC
void set_classic_grid_img(PImage img) {
    bitmap_set_analyze() ;
  int step_x = 10 ;
  int step_y = 10 ;
  bitmap_analyze(img, step_x, step_y) ;

}
void classic_grid_img() {
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

