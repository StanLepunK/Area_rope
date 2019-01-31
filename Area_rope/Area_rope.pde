/**
AREA ROPE
* @see https://github.com/StanLepunK/Rope_examples
2018-2019
*/

PImage img ;
Area area ;
int step = 5 ; 
int bags = 12 ;

void setup() {
  size(800,600) ;
  //img = loadImage("pirate.jpg") ;
  // img = loadImage("purosGirl.jpg") ;
  // img = loadImage("Lena_Soderberg.jpg") ;
  // img = loadImage("mire.jpg") ;
  // img = loadImage("no_future.jpg") ;
  // img = loadImage("Liberte.jpg") ;
  img = loadImage("RioCarnaval.jpg") ;
  // img = loadImage("Joconde.jpg") ;
  surface.setSize(img.width, img.height) ;
  area = new Area(img, step, bags, RED_SORT) ;
 
}


float rotation ;
void draw() {

  background_rope(0) ;
  simple_display() ;
  // by_bag() ;
  // by_pixel() ;
  curve_info() ;
}

// simple
void simple_display() {
  for(int i = 0 ; i < area.size() ; i++) {
    int size_bag = area.get(i).size() ;
    for(int k = 0 ; k < size_bag ; k++) {
      int c = area.get(i).get_colour(k) ;
      vec2 pos = area.get(i).get_pos(k) ;
      int size = 5 ;
      point(pos) ;
      strokeWeight(size) ;
      stroke(c, 50) ;     
    }  
  } 
}

// bag
void by_bag() {
  rotation += .1 ;
  int speed = 1 ;
  for(int i = 0 ; i < speed ; i ++) {
    int which_bag = floor(random(area.size())) ;
    int size_bag = floor(area.get(which_bag).size()) ;
    for(int k = 0 ; k < size_bag ; k++ ) {
      int c =  area.get(which_bag).get_colour(k) ;
      vec2 pos = area.get(which_bag).get_pos(k) ;
      fill(c) ;
      noStroke() ;
      int size = (int)random(5,10) ;
      int shape = (int)random(4, 10) ;
      costume(pos,vec2(size), rotation, TRIANGLE_ROPE) ;
      // costume_rope(pos, size, rotation, shape) ;
    }
  }
}






void by_pixel() {
    rotation += .1 ;
  int speed = 40 ;
  for(int i = 0 ; i < speed ; i ++) {
    int which_bag = floor(random(area.size())) ;
    int which_pix = floor(random(area.get(which_bag).size())) ;
    int c =  area.get(which_bag).get_colour(which_pix) ;
    vec2 pos = area.get(which_bag).get_pos(which_pix) ;
    fill(c, 50) ;
    noStroke() ;
    int size = (int)random(5,10) ;
    int shape = (int)random(4, 10) ;
    costume(pos,vec2(size), rotation, TRIANGLE_ROPE) ;
    // costume_rope(pos, size, rotation, shape) ;
  }

}




void curve_info() {
  stroke(0, 126) ;
  strokeWeight(1) ;
  int [] pix_num = area.classify_components(img, BRIGHTNESS_SORT, bags) ;
  int pos_x = width /10  ;
  int pos_y = height/2 ;
  for(int i = 0 ; i < pix_num.length ; i++) {
    float x_1 = pos_x + i;
    float x_2 = pos_x + i;
    float y_1 = pos_y;
    float y_2 = pos_y - ((float)pix_num[i] *.01);
    line(x_1, y_1, x_2, y_2) ;
  }
}