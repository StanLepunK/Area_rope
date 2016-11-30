Aera_rope 0.0.1 
Romanesco Processing Environment 2016-2016
--
Mini library to create area from picture of type PImage ; PImage is class from Processing.
You can sort your picture with the alpha, red, green, blue, hue, saturation and brightness.
You can split your picture in bags.
And after you can choice to display wich bag you wish and which pixel you want in a specific bag.

the class Area return a Vec3 list, where the 'x and 'y' is a 2D position and 'z' is the int colour, becareful you must cast the 'z' component because Vec return a float component.


Create Area object
--
Area your_obj = new Area(area = new Area(PImage img, int step, int num_bags, int type) ;
>img is your img from Processing
>step it's your step grid
>num_bags, the quantity of diffenrents group of components Processing must split your picture.
>for the type you can use the constants :
>final int ALPHA_SORT = 0 ;

>final int RED_SORT = 1 ;

>final int GREEN_SORT = 2 ;

>final int BLUE_SORT = 3 ;

>final int HUE_SORT = 4 ;

>final int SATURATION_SORT = 5 ;

>final int BRIGHTNESS_SORT = 6 ;


your_obj.get(int group) ;
> return obj of type Bag

your_obj.size() ;
> return the int num of Bag in your Object Area

int [] your_obj.classify_components(Pimage img, int BRIGHTNESS_SORT, int num_bags) ;
>return an array list of int with quantity of pixel for each segment, the num of segment in the num from the componennt color from you colour environment,
>if you've 'colorMode(RGB, 100,50,50,100' the segmenets quantity for the 'red' is 100, 50 for the 'green', 50 for the 'blue' and 100 for the 'alpha'.


your_obj.get(int group).get(int pix)
>return an obj of type Vec3
>this Vec3 ruturn 3 component x,y and z
>x is the x position
>y is the z position
>z is the colour int, you must cast it.

your_obj.get(int group).get_colour(int pix) ;
> return the int colour

your_obj.get(int group).get_pos(int pix) ;
>return a Vec2 pos

your_obj.get(int group).size() ;
>return the int num of colour present in this bag