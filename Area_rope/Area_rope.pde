PImage img ;
Area area ;
void setup() {
  size(800,600) ;
  // img = loadImage("pirate.jpg") ;
  img = loadImage("purosGirl.jpg") ;
  
  surface.setSize(img.width, img.height) ;
  
  int step = 5 ; 
  int bags = 3 ;
  area = new Area(img, step, bags, BRIGHTNESS_SORT) ;
  println(area.size()) ;

   
}


float rotation ;
void draw() {
  // background_rope(0, 5) ;
  /*
  for(int i = 0 ; i < area.size() ; i++) {
    int size_bag = area.get(i).size() ;
    for(int k = 0 ; k < size_bag ; k++) {
      int c = area.get(i).get_colour(k) ;
      Vec2 pos = area.get(i).get_pos(k) ;
      point(pos) ;
      strokeWeight(2) ;
      stroke(c) ;
      
    }  
  } 
  */
  rotation += .1 ;
  int speed = 40 ;
  for(int i = 0 ; i < speed ; i ++) {
    int which_bag = floor(random(area.size())) ;
    int which_pix = floor(random(area.get(which_bag).size())) ;
    int c =  area.get(which_bag).get_colour(which_pix) ;
    Vec2 pos = area.get(which_bag).get_pos(which_pix) ;
    fill(c, 50) ;
    noStroke() ;
    int size = (int)random(5,35) ;
    int shape = (int)random(13, 22) ;
    // costume_rope(pos, size, rotation, TRIANGLE_ROPE) ;
    costume_rope(pos, size, rotation, shape) ;
  }
}