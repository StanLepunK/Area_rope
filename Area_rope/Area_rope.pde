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
  for(int i = 0 ; i < area.size() ; i++) {
   // println(area.get(i).colour_ID) ;
   // println(area.get(i).size()) ;
    int size_bag = area.get(i).size() ;
    for(int k = 0 ; k < size_bag ; k++) {
      int c = area.get(i).get_colour(k) ;
      Vec2 pos = area.get(i).get_pos(k) ;
      point(pos) ;
      strokeWeight(2) ;
      stroke(c) ;
      
    }  
  }

  
  // background(0) ;
  // classic_grid_img() ; 
  
}


// CLASSIC
/*
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
*/