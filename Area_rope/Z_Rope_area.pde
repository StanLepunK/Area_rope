/**
Area_ROPE 0.0.3
Romanesco Processing Environment 2016–2016
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
  boolean mirror_img = false ;
  
  Area (PImage img, int step, int num_bag, int type_sort) {
    palette = new ArrayList<Colour_bag>() ;
    create_bag(num_bag, type_sort) ;
    analyze(img, step, step, num_bag, type_sort) ;
    int [] pixel_rank = classify_components(img, type_sort, num_bag) ;
    println("rank") ;
    printArray(pixel_rank) ;
    int [] best_pixel = best_components(pixel_rank, num_bag) ;
    println("best") ;
    printArray(best_pixel) ;
  }

  // 
  protected int size() {
    return palette.size() ;
  }
  
  private Colour_bag get(int target) {
    return palette.get(target) ;
  }
  
  // 
  private void mirror(boolean mirror_img) {
    this.mirror_img = mirror_img ;
  }
  
  // find the component
  private int[] best_components(int [] list, int num_bag) {
    int [] best_component = new int[num_bag] ;
    int [] best = new int[num_bag] ;
    int [] score = new int[num_bag] ;
    //int best = -1 ;
    for(int i = 0 ; i < best.length ; i++) {
      for(int k = 0 ; k < list.length ; k++) {
        if(list[k] > score[i]) {
          if(i > 0) {
            int scoring = 0 ;
            for(int m = i ; m > 0 ; m--) {
              if(list[k] != score[m-1]) {
                scoring++ ;
              }
            }
            if(scoring >= i) {
              best[i] = k ;
              score[i] = list[k] ;
            } 
          } else { 
            best[i] = k ; 
            score[i] = list[k] ;
          }     
        }
      }
    }
    return best ;
    

  }

  private int[] classify_components(PImage img, int type_sort, int num_bag) {
    int [] components ;
    // int [] best_component = new int[num_bag] ;
    
    int num = 1 ; 
    img.loadPixels() ;


    // ahpha
    if(type_sort == ALPHA_SORT) {
      num = (int)g.colorModeA ;
      components = new int[minimum_components(num, num_bag)] ;
      for(int i = 0 ; i < components.length ; i++) {
        components[i] = 0 ;
      }
      for(int i = 0 ; i < img.pixels.length ; i++) {
        int value = (int)alpha(img.pixels[i]) ;
        components[value] ++ ;
      }
      return components ;
    // red
    } else if(type_sort == RED_SORT) {
      num = (int)g.colorModeX ;
      components = new int[minimum_components(num, num_bag)] ;
      for(int i = 0 ; i < components.length ; i++) {
        components[i] = 0 ; 
      }
      for(int i = 0 ; i < img.pixels.length ; i++) {
        int value = (int)red(img.pixels[i]) ;
        components[value] ++ ;
      }
      return components ; 
    // green
    } else if(type_sort == GREEN_SORT) {
      num = (int)g.colorModeY ;
      components = new int[minimum_components(num, num_bag)] ;
      for(int i = 0 ; i < components.length ; i++) {
        components[i] = 0 ; 
      }
      for(int i = 0 ; i < img.pixels.length ; i++) {
        int value = (int)green(img.pixels[i]) ;
        components[value] ++ ;
      }
      return components ;
    // blue  
    } else if(type_sort == BLUE_SORT) {
      num = (int)g.colorModeZ ;
      components = new int[minimum_components(num, num_bag)] ;
      for(int i = 0 ; i < components.length ; i++) {
        components[i] = 0 ; 
      }
      for(int i = 0 ; i < img.pixels.length ; i++) {
        int value = (int)blue(img.pixels[i]) ;
        components[value] ++ ;
      }
      return components ;
    // hue  
    } else if(type_sort == HUE_SORT) {
      num = (int)g.colorModeX ;
      components = new int[minimum_components(num, num_bag)] ;
      for(int i = 0 ; i < components.length ; i++) {
        components[i] = 0 ; 
      }
      for(int i = 0 ; i < img.pixels.length ; i++) {
        int value = (int)hue(img.pixels[i]) ;
        components[value] ++ ;
      }
      return components ;
    // hue  
    } else if(type_sort == SATURATION_SORT) {
      num = (int)g.colorModeY ;
      components = new int[minimum_components(num, num_bag)] ;
      for(int i = 0 ; i < components.length ; i++) {
        components[i] = 0 ; 
      }
      for(int i = 0 ; i < img.pixels.length ; i++) {
        int value = (int)saturation(img.pixels[i]) ;
        components[value] ++ ;
      }
      return components ;
    // brightness  
    } else if(type_sort == BRIGHTNESS_SORT) {
      num = (int)g.colorModeZ +1 ;
      components = new int[minimum_components(num, num_bag)] ;
      for(int i = 0 ; i < components.length ; i++) {
        components[i] = 0 ; 
      }
      for(int i = 0 ; i < img.pixels.length ; i++) {
        int value = floor(brightness(img.pixels[i])) ;
        components[value] ++ ;
      }
      return components ; 
    } else return null ;
  }
  
  private int minimum_components(int num, int num_bag) {
    int minimum_component = 11 ;
    if(num < minimum_component) num = minimum_component ;
    else if(num < num_bag) num = num_bag ;
    return num ;
  }
  




  // area img
  private void analyze(PImage img, int step_x, int step_y, int num_bag, int type_sort) {
    float [] colour_pointer = new float[num_bag] ;
    float range = range_size(num_bag, type_sort) ;

    for(int x = 0 ;  x < img.width ; x = x + step_x) {
      for(int y = 0 ; y < img.height ; y = y + step_y) {
        manage_bag(img, x, y, type_sort, range) ;
      }
    }
  }
  
  // manage bag
  private void manage_bag(PImage img, int x, int y, int type_sort, float range) {
    int which_pix = 0 ;
    // pixel position
    if(!mirror_img) {
      which_pix =  y*img.width +x; 
    } else {
      // Reversing x to mirror the image
     which_pix = (img.width -x -1) + y*img.width; 
    }
    
    int c = img.get(x,y) ;

    if(match_bag(c, range, type_sort)) {
        add_colour_in_bag(x, y, c, range, type_sort) ;
      } else {
        // 
      }
  }


  // create bag
  private void create_bag(int num, int type_sort) {
    float range =  range_size(num, type_sort) ;
    float colour_ID = range *.5 ;
    for(int i = 0 ; i < num ; i++) {
      Colour_bag bag = new Colour_bag(colour_ID) ;
      colour_ID += range ;
      palette.add(bag) ;
    }
  }



  //add color in a specific bag
  private void add_colour_in_bag(int x, int y, int c, float range, int type_sort) {
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
  private boolean match_bag(int colour, float range, int type_sort) {
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
        if(result) break ;
      }
    } else {
      result = false ;
    }
    return result ;
  }

  private float select_component(int c, int type_sort) {
    if(type_sort == ALPHA_SORT) return alpha(c) ;
    else if(type_sort == RED_SORT) return red(c) ;
    else if(type_sort == GREEN_SORT) return green(c) ;
    else if(type_sort == BLUE_SORT) return blue(c) ;
    else if(type_sort == HUE_SORT) return hue(c) ;
    else if(type_sort == SATURATION_SORT) return saturation(c) ;
    else if(type_sort == BRIGHTNESS_SORT) return brightness(c) ;
    else return brightness(c) ;
  }

  private float range_size(int num, int type_sort) {
    if(type_sort == ALPHA_SORT) return g.colorModeA / num ;
    else if(type_sort == RED_SORT) return g.colorModeX / num  ;
    else if(type_sort == GREEN_SORT) return g.colorModeY / num ;
    else if(type_sort == BLUE_SORT) return g.colorModeY / num ;
    else if(type_sort == HUE_SORT) return g.colorModeZ / num ;
    else if(type_sort == SATURATION_SORT) return g.colorModeY / num ;
    else if(type_sort == BRIGHTNESS_SORT) return g.colorModeZ / num ;
    else return g.colorModeZ / num ;
  }


  // internal class
  private class Colour_bag {
    ArrayList<Vec3> bag ;
    float colour_ID ;

    private Colour_bag(float colour_ID) {
      this.colour_ID = colour_ID ;
      bag = new ArrayList<Vec3>()  ;
    }


    private void add(int x, int y, int c) {
      bag.add(Vec3(x,y,c)) ;
    }
    
    private int size() {
      return bag.size() ;
    }
    
    
    private Vec3 get(int target) {
      Vec3 v = bag.get(target) ;
      return v ;
    }
    
    private Vec2 get_pos(int target) {
      Vec3 v = bag.get(target) ;
      return Vec2(v.x,v.y) ;
    }
    
    private int get_colour(int target) {
      Vec3 v = bag.get(target) ;
      return (int)v.z ;
    }
  }


}




