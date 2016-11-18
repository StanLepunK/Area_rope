/**
Area_ROPE 0.0.1 
Romanesco Processing Environment 2016–2016
*/
boolean mirror_area = false ;
void mirror(boolean mirror_aera) {
  this.mirror_area = mirror_area ;
}


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
      if(!mirror_area) {
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



/**
AREA
*/
class Area {
  ArrayList<Colour_area> palette ;
  boolean mirror_image = false ;
  Area (PImage img, int step, int num_bag, int type_sort) {
    palette = new ArrayList<Colour_area>() ;
    analyze(img, step, step, num_bag, type_sort) ;

  }
  
  int ALPHA_SORT = 0 ;
  int RED_SORT = 1 ;
  int GREEN_SORT = 2 ;
  int BLUE_SORT = 3 ;
  int HUE_SORT = 4 ;
  int SATURATION_SORT = 5 ;
  int BRIGHTNESS_SORT = 6 ;
  
  // area img
  void analyze(PImage img, int step_x, int step_y, int num_bag, int type_sort) {
    palette.clear() ;
    float [] colour_pointer = new float[num_bag] ;
    float range_colour = range_size(num_bag, type_sort) ;

    // check color ;
    int which_pix = 0 ;
    for(int x = 0 ;  x < img.width ; x = x + step_x) {
      for(int y = 0 ; y < img.height ; y = y + step_y) {
        // pixel position
        if(!mirror_image) {
          which_pix =  y*img.width +x; 
        } else {
          // Reversing x to mirror the image
         which_pix = (img.width -x -1) + y*img.width; 
        }
        
        // int c = img.pixels[which_pix] ;
        int c = img.get(x,y) ;
        // float colour_ID = select_component(c, type_sort) ;

        if(palette.size() > 0 && check_bag(c, range_colour, type_sort)) {

        } else {
          Colour_area area = new Colour_area() ;
          float colour_ID = select_component(c, type_sort) ;
          area.add(x,y,c, colour_ID) ;
          palette.add(area) ;
   
        }
        Vec3 pix = Vec3(x,y,c) ;
        pix_list.add(pix) ;
      }
    }
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


  boolean check_bag(int colour, float range, int type_sort) {
    boolean result = false ;
    if(palette.size() > 0) {
      for(Colour_area bag : palette) {
        float min = bag.colour_ID - (range *.5) ;
        float max = bag.colour_ID + (range *.5) ;
        if(type_sort == ALPHA_SORT) result = alpha_range(min, max, colour) ;
        else if(type_sort == RED_SORT) result = red_range(min, max, colour) ;
        else if(type_sort == GREEN_SORT) result = green_range(min, max, colour) ;
        else if(type_sort == BLUE_SORT) result = blue_range(min, max, colour) ;
        else if(type_sort == HUE_SORT) result = hue_range(min, max, colour) ;
        else if(type_sort == SATURATION_SORT) result = saturation_range(min, max, colour) ;
        else if(type_sort == BRIGHTNESS_SORT) result = brightness_range(min, max, colour) ;
        else result = brightness_range(min, max, colour) ;
      }
    } else result = false ;
    return result ;
    
  }
}




class Colour_area {
  ArrayList<Vec3> bag ;
  float colour_ID ;

  Colour_area() {
    bag = new ArrayList<Vec3>()  ;
  }


  void add(int x, int y, int c, float colour_ID) {
    this.colour_ID = colour_ID ;
    bag.add(Vec3(x,y,c)) ;
  }
}



