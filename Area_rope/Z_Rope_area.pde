/**
Area_ROPE 0.0.1 
Romanesco Processing Environment 2016–2016
*/
boolean mirror_img = false ;
void mirror(boolean mirror_img) {
  this.mirror_img = mirror_img ;
}

/*
ArrayList<Vec3> pix_list ;
void bitmap_set_analyze() {
  pix_list = new ArrayList<Vec3>() ;
}


void bitmap_analyze(PImage img, int step_x, int step_y) {
  pix_list.clear() ;
  // check color ;
  int which_pix = 0 ;
  for(int x = 0 ;  x < img.width ; x = x + step_x) {
    for(int y = 0 ; y < img.height ; y = y + step_y) {
      // pixel position
      if(!mirror_img) {
        which_pix =  y*img.width +x; 
      } else {
        // Reversing x to mirror the image
       which_pix = (img.width -x -1) + y*img.width; 
      }
      
      // int c = img.pixels[which_pix] ;
      int c = img.get(x,y) ;
      Vec3 pix = Vec3(x,y,c) ;
      pix_list.add(pix) ;
    }
  }
}
*/


/**
AREA
*/
final int ALPHA_SORT = 0 ;
final int RED_SORT = 1 ;
final int GREEN_SORT = 2 ;
final int BLUE_SORT = 3 ;
final int HUE_SORT = 4 ;
final int SATURATION_SORT = 5 ;
final int BRIGHTNESS_SORT = 6 ;

class Area {
  ArrayList<Colour_bag> palette ;
  
  Area (PImage img, int step, int num_bag, int type_sort) {
    palette = new ArrayList<Colour_bag>() ;
    create_bag(num_bag, type_sort) ;
    analyze(img, step, step, num_bag, type_sort) ;

  }

  // 
  int size() {
    return palette.size() ;
  }
  
  Colour_bag get(int target) {
    return palette.get(target) ;
  }
  

  // area img
  void analyze(PImage img, int step_x, int step_y, int num_bag, int type_sort) {
    float [] colour_pointer = new float[num_bag] ;
    float range = range_size(num_bag, type_sort) ;

    for(int x = 0 ;  x < img.width ; x = x + step_x) {
      for(int y = 0 ; y < img.height ; y = y + step_y) {
        manage_bag(img, x, y, type_sort, range) ;
      }
    }
  }
  
  // manage bag
  int count  = 0 ;
  void manage_bag(PImage img, int x, int y, int type_sort, float range) {
    count ++ ;
    int which_pix = 0 ;
    // pixel position
    if(!mirror_img) {
      which_pix =  y*img.width +x; 
    } else {
      // Reversing x to mirror the image
     which_pix = (img.width -x -1) + y*img.width; 
    }
    
    // int c = img.pixels[which_pix] ;
    int c = img.get(x,y) ;
    // float colour_ID = select_component(c, type_sort) ;
    // println(match_bag(c, range_colour, type_sort), select_component(c, type_sort), range_colour, type_sort) ;
    if(match_bag(c, range, type_sort)) {
        add_colour_in_bag(x, y, c, range, type_sort) ;
        // println("current bag", count) ;
      } else {
        // create a new colour bag
        // println("new bag", count) ;
        // create_bag(x, y, c, type_sort) ;
      }
  }


  // create bag
  void create_bag(int num, int type_sort) {
    float range =  range_size(num, type_sort) ;
    float colour_ID = range *.5 ;
    for(int i = 0 ; i < num ; i++) {
      Colour_bag bag = new Colour_bag(colour_ID) ;
      colour_ID += range ;
      palette.add(bag) ;
    }
  }
  /*
  void create_bag(int x, int y, int c, int type_sort) {
    float colour_ID = select_component(c, type_sort) ;
    Colour_bag bag = new Colour_bag(colour_ID) ;
    Vec3 pix = Vec3(x,y,c) ;
    bag.add(x,y,c) ;
    palette.add(bag) ;
  }
  */


  //add color in a specific bag
  void add_colour_in_bag(int x, int y, int c, float range, int type_sort) {
    if(palette.size() > 0) {
      for(Colour_bag bag : palette) {
        float min = bag.colour_ID - (range *.5) ;
        float max = bag.colour_ID + (range *.5) ;

        if(type_sort == ALPHA_SORT) {
          if(alpha_range(min, max, c)) {
            bag.add(x,y,c) ;
          } 
        } else if(type_sort == RED_SORT) {
          if(red_range(min, max, c)) {
            bag.add(x,y,c) ;
          } 
        } else if(type_sort == GREEN_SORT) {
          if(green_range(min, max, c)) { 
            bag.add(x,y,c) ;
          } 
        } else if(type_sort == BLUE_SORT) { 
          if(blue_range(min, max, c)) {
            bag.add(x,y,c) ;
          } 
        } else if(type_sort == HUE_SORT) {
          if(hue_range(min, max, c)) {
            bag.add(x,y,c) ;
          } 
        } else if(type_sort == SATURATION_SORT) {
          if(saturation_range(min, max, c)) {
            bag.add(x,y,c) ;
          } 
        } else if(type_sort == BRIGHTNESS_SORT) {
          if(brightness_range(min, max, c)) {
            bag.add(x,y,c) ;
          } 
        } 
      }
    } 
  }
  
  // check bag if the new pixel match with any bag existing
  boolean match_bag(int colour, float range, int type_sort) {
    boolean result = false ;
    if(palette.size() > 0) {
      for(Colour_bag bag : palette) {
        
        float min = bag.colour_ID - (range *.5) ;
        float max = bag.colour_ID + (range *.5) ;

        if(type_sort == ALPHA_SORT) {
          result = alpha_range(min, max, colour) ;
        } else if(type_sort == RED_SORT) {
          result = red_range(min, max, colour) ;
        } else if(type_sort == GREEN_SORT) {
          result = green_range(min, max, colour) ;
        } else if(type_sort == BLUE_SORT) { 
          result = blue_range(min, max, colour) ;
        } else if(type_sort == HUE_SORT) {
          result = hue_range(min, max, colour) ;
        } else if(type_sort == SATURATION_SORT) {
          result = saturation_range(min, max, colour) ;
        } else if(type_sort == BRIGHTNESS_SORT) {
          result = brightness_range(min, max, colour) ;
        } else result = brightness_range(min, max, colour) ;
      }
    } else {
      result = false ;
    }
    return result ;
  }

  float select_component(int c, int type_sort) {
    if(type_sort == ALPHA_SORT) return alpha(c) ;
    else if(type_sort == RED_SORT) return red(c) ;
    else if(type_sort == GREEN_SORT) return green(c) ;
    else if(type_sort == BLUE_SORT) return blue(c) ;
    else if(type_sort == HUE_SORT) return hue(c) ;
    else if(type_sort == SATURATION_SORT) return saturation(c) ;
    else if(type_sort == BRIGHTNESS_SORT) return brightness(c) ;
    else return brightness(c) ;
  }

  float range_size(int num, int type_sort) {
    if(type_sort == ALPHA_SORT) return g.colorModeA / num ;
    else if(type_sort == RED_SORT) return g.colorModeX / num  ;
    else if(type_sort == GREEN_SORT) return g.colorModeY / num ;
    else if(type_sort == BLUE_SORT) return g.colorModeY / num ;
    else if(type_sort == HUE_SORT) return g.colorModeZ / num ;
    else if(type_sort == SATURATION_SORT) return g.colorModeY / num ;
    else if(type_sort == BRIGHTNESS_SORT) return g.colorModeZ / num ;
    else return g.colorModeZ / num ;
  }


  
}




class Colour_bag {
  ArrayList<Vec3> bag ;
  float colour_ID ;

  Colour_bag(float colour_ID) {
    this.colour_ID = colour_ID ;
    bag = new ArrayList<Vec3>()  ;
  }


  void add(int x, int y, int c) {
    bag.add(Vec3(x,y,c)) ;
  }
  
  int size() {
    return bag.size() ;
  }
  
  
  Vec3 get(int target) {
    Vec3 v = bag.get(target) ;
    return v ;
  }
  Vec2 get_pos(int target) {
    Vec3 v = bag.get(target) ;
    return Vec2(v.x,v.y) ;
  }
  
  int get_colour(int target) {
    Vec3 v = bag.get(target) ;
    return (int)v.z ;
  }
}