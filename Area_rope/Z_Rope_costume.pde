/**
RPE Costume 0.2.1 – 2016-2016
* @author Stan le Punk
* @see https://github.com/StanLepunK/Costume_rope
*/
final int POINT_ROPE = 0 ;
final int ELLIPSE_ROPE = 1 ;
final int RECT_ROPE = 2 ;
final int LINE_ROPE = 3 ;

final int TRIANGLE_ROPE = 13 ;
final int SQUARE_ROPE = 14 ;
final int PENTAGON_ROPE = 15 ;
final int HEXAGON_ROPE = 16 ;
final int HEPTAGON_ROPE = 17 ;
final int OCTOGON_ROPE = 18 ;
final int NONAGON_ROPE = 19 ;
final int DECAGON_ROPE = 20 ;
final int HENDECAGON_ROPE = 21 ;
final int DODECAGON_ROPE = 22 ;

final int CROSS_2_ROPE = 52 ;
final int CROSS_3_ROPE = 53 ;

final int SPHERE_LOW_ROPE = 100 ;
final int SPHERE_MEDIUM_ROPE = 101 ;
final int SPHERE_HIGH_ROPE = 102 ;
final int TETRAHEDRON_ROPE = 103 ;
final int BOX_ROPE = 104 ;

final int TETRAHEDRON_LINE_ROPE = 1001 ;
final int CUBE_LINE_ROPE = 1002 ;
final int OCTOHEDRON_LINE_ROPE = 1003 ;
final int RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE_ROPE = 1004 ;
final int ICOSI_DODECAHEDRON_LINE_ROPE = 1005 ;




Info_int_dict costume_dict = new Info_int_dict() ;
boolean list_costume_is_built = false ;
int ref_size_pic = -1 ;
void costume_list() {
	if(!list_costume_is_built) {
		costume_dict.add("POINT_ROPE", POINT_ROPE, 2, 0) ;
		costume_dict.add("ELLIPSE_ROPE", ELLIPSE_ROPE, 2, 0) ;
		costume_dict.add("RECT_ROPE", RECT_ROPE, 2, 0) ;
		costume_dict.add("LINE_ROPE", LINE_ROPE, 2, 0) ;

		costume_dict.add("TRIANGLE_ROPE", TRIANGLE_ROPE, 2, 0) ;
		costume_dict.add("SQUARE_ROPE", SQUARE_ROPE, 2, 0) ;
		costume_dict.add("PENTAGON_ROPE", PENTAGON_ROPE, 2, 0) ;
		costume_dict.add("HEXAGON_ROPE", HEXAGON_ROPE, 2, 0) ;
		costume_dict.add("HEPTAGON_ROPE", HEPTAGON_ROPE, 2, 0) ;
		costume_dict.add("OCTOGON_ROPE", OCTOGON_ROPE, 2, 0) ;
		costume_dict.add("NONAGON_ROPE", NONAGON_ROPE, 2, 0) ;
		costume_dict.add("DECAGON_ROPE", DECAGON_ROPE, 2, 0) ;
		costume_dict.add("HENDECAGON_ROPE", HENDECAGON_ROPE, 2, 0) ;
		costume_dict.add("DODECAGON_ROPE", DODECAGON_ROPE, 2, 0) ;

		costume_dict.add("CROSS_2_ROPE", CROSS_2_ROPE, 3, 0) ;
		costume_dict.add("CROSS_3_ROPE", CROSS_3_ROPE, 3, 0) ;

		costume_dict.add("SPHERE_LOW_ROPE", SPHERE_LOW_ROPE, 3, 0) ;
		costume_dict.add("SPHERE_MEDIUM_ROPE", SPHERE_MEDIUM_ROPE, 3, 0) ;
		costume_dict.add("SPHERE_HIGH_ROPE", SPHERE_HIGH_ROPE, 3, 0) ;
		costume_dict.add("TETRAHEDRON_ROPE", TETRAHEDRON_ROPE, 3, 0) ;
		costume_dict.add("BOX_ROPE", BOX_ROPE, 3, 0) ;

		costume_dict.add("TETRAHEDRON_LINE_ROPE", TETRAHEDRON_LINE_ROPE, 3, 3) ;
		costume_dict.add("CUBE_LINE_ROPE", CUBE_LINE_ROPE, 3, 3) ;
		costume_dict.add("OCTOHEDRON_LINE_ROPE", OCTOHEDRON_LINE_ROPE, 3, 3) ;
		costume_dict.add("RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE_ROPE", RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE_ROPE, 3, 3) ;
		costume_dict.add("ICOSI_DODECAHEDRON_LINE_ROPE", ICOSI_DODECAHEDRON_LINE_ROPE, 3, 3) ;

		list_costume_is_built = true ;
	}

  // add costume from your SVG or PNG
	if(ref_size_pic != costume_pic_list.size()) {
		for(Costume_pic c : costume_pic_list) {
			costume_dict.add(c.name, c.ID, 3, c.type) ;
		}
		ref_size_pic = costume_pic_list.size() ;
	}
}


// print list costume
void print_list_costume() {
	if(!list_costume_is_built) {
		costume_list() ;
	}
  println("Costume have " + costume_dict.size() + " costumes.") ;
	if(list_costume_is_built) {
		for(int i = 0 ; i < costume_dict.size() ; i++) {
			String type = "" ;
			if(costume_dict.get(i).get(2) == 0 ) type = "shape" ;
			else if(costume_dict.get(i).get(2) == 1 ) type = "bitmap" ;
			else if(costume_dict.get(i).get(2) == 2 ) type = "scalable vector graphics" ;
			else if(costume_dict.get(i).get(2) == 3 ) type = "shape with no fill component" ;
			println("[ Rank:", i, "][ ID:",costume_dict.get(i).get(0), "][ Name:", costume_dict.get(i).get_name(), "][ Renderer:", costume_dict.get(i).get(1)+"D ][ Picture:", type, "]") ;
		}
	}
}


// get costume
int get_costume(int rank) {
	costume_list() ;
	if(rank >= 0 && rank < costume_dict.size()) {
		return costume_dict.get(rank).get(0) ;
	} else {
		System.err.println("Your rank is out from the list") ;
		return 0 ;
	}
}


// return size of the arrayList costume
int costumes_size() {
	costume_list() ;
	return costume_dict.size() ;
}









/**
add pic
*/
ArrayList <Costume_pic> costume_pic_list = new ArrayList<Costume_pic>() ;

void load_costume_pic(String path) {
	if(path.endsWith("png") || path.endsWith("PNG") || path.endsWith("svg") || path.endsWith("SVG")) {
		int new_ID = costume_pic_list.size() * (-1) ;
		new_ID -= 1 ;
		Costume_pic c = new Costume_pic(this, path, new_ID) ;
		costume_pic_list.add(c) ; ;
		println("ID pic:", new_ID) ;
	}
}



class Costume_pic {
	PImage img ;
	ROPE_svg svg ;
	int type = -1 ; 

	String name ;
	int ID ;
	Costume_pic(PApplet p5, String path, int ID) {
		// add png
		if(path.endsWith("png") || path.endsWith("PNG")) {
			img = loadImage(path) ;
			type = 1 ;
		}

		// add svg
		if(path.endsWith("svg") || path.endsWith("SVG")) {
			svg = new ROPE_svg(p5, path) ;
						svg.mode(CENTER) ;
			svg.build() ;
			type = 2 ;
		}
		
		String [] split = path.split("/") ;
		name = split[split.length -1] ;
		name = name.substring(0, name.lastIndexOf(".")) ;
		this.ID = ID ;
	}
}












/**
// display costume
*/
// 3D
void costume_rope(Vec3 pos, int size_int, int which_costume)  {
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	float angle = 0 ;
	costume_rope(pos, size, angle, dir_null, which_costume) ;
}

void costume_rope(Vec3 pos, Vec3 size, int which_costume)  {
	Vec3 dir_null = Vec3() ;
	float angle = 0 ;
	costume_rope(pos, size, angle, dir_null, which_costume) ;
}

void costume_rope(Vec3 pos, Vec3 size, float angle, int which_costume)  {
	Vec3 dir_null = Vec3() ;
	costume_rope(pos, size, angle, dir_null, which_costume) ;
}

void costume_rope(Vec3 pos, Vec3 size, Vec dir, int which_costume)  {
	float angle = 0 ;
	costume_rope(pos, size, dir, which_costume) ;
}


//costume_rope(Vec3 pos, Vec3 size, float angle, Vec dir, int which_costume)


// 2D
void costume_rope(Vec2 pos, int size_int, int which_costume)  {
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	float angle = 0 ;
  Vec3 new_pos = Vec3(pos.x, pos.y, 0) ;
	costume_rope(new_pos, size, angle,  dir_null, which_costume) ;
}
// costume_rope(Vec3 pos, Vec3 size, float angle, Vec dir, int which_costume)
void costume_rope(Vec2 pos, Vec3 size, int which_costume)  {
	Vec3 dir_null = Vec3() ;
	float angle = 0 ;
	costume_rope(Vec3(pos.x,pos.y,0), size, angle, dir_null, which_costume) ;
}

void costume_rope(Vec2 pos, int size_int, float angle, int which_costume)  {
	Vec3 dir_null = Vec3() ;
	Vec3 size = Vec3(size_int) ;
	costume_rope(Vec3(pos.x,pos.y,0), size, angle, dir_null, which_costume) ;
}

void costume_rope(Vec2 pos, Vec3 size, float angle, int which_costume)  {
	Vec3 dir_null = Vec3() ;
	costume_rope(Vec3(pos.x,pos.y,0), size, angle, dir_null, which_costume) ;
}





/**
Change the method for method with 
case
and 
break
*/
void costume_rope(Vec3 pos, Vec3 size, float angle, Vec dir, int which_costume) {
	if(dir instanceof Vec2) {
    // direction polar
	} else if (dir instanceof Vec3) {
    // direction cartesian
	} else {
    //
	}

	if (which_costume == POINT_ROPE) {
    strokeWeight(size.x) ;
		point(pos) ;
	} else if (which_costume == ELLIPSE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		ellipse(0,0, size.x, size.y) ;
		stop_matrix() ;
	} else if (which_costume == RECT_ROPE) {
		start_matrix() ;
		translate(pos) ;
		rect(0,0, size.x, size.y) ;
		stop_matrix() ;
	} else if (which_costume == LINE_ROPE) {
		primitive(pos, size.x, 2, angle) ;
	}



		else if (which_costume == TRIANGLE_ROPE) {
		primitive(pos, size.x, 3, angle) ;
	}  else if (which_costume == SQUARE_ROPE) {
		primitive(pos, size.x, 4, angle) ;
	} else if (which_costume == PENTAGON_ROPE) {
		primitive(pos, size.x, 5, angle) ;
	} else if (which_costume == HEXAGON_ROPE) {
		primitive(pos, size.x, 6, angle) ;
	} else if (which_costume == HEPTAGON_ROPE) {
		primitive(pos, size.x, 7, angle) ;
	} else if (which_costume == OCTOGON_ROPE) {
		primitive(pos, size.x, 8, angle) ;
	} else if (which_costume == NONAGON_ROPE) {
		primitive(pos, size.x, 9, angle) ;
	} else if (which_costume == DECAGON_ROPE) {
		primitive(pos, size.x, 10, angle) ;
	} else if (which_costume == HENDECAGON_ROPE) {
		primitive(pos, size.x, 11, angle) ;
	} else if (which_costume == DODECAGON_ROPE) {
		primitive(pos, size.x, 12, angle) ;
	}



		else if (which_costume == CROSS_2_ROPE) {
		start_matrix() ;
		translate(pos) ;
		cross_2(size) ;
		stop_matrix() ;
	} else if (which_costume == CROSS_3_ROPE) {
		start_matrix() ;
		translate(pos) ;
		cross_3(size) ;
		stop_matrix() ;
	}




		else if (which_costume == SPHERE_LOW_ROPE) {
		start_matrix() ;
		translate(pos) ;
		sphereDetail(5);
		sphere(size.x) ;
		stop_matrix() ;
	} else if (which_costume == SPHERE_MEDIUM_ROPE) {
		start_matrix() ;
		translate(pos) ;
		sphereDetail(12);
		sphere(size.x) ;
		stop_matrix() ;
	}else if (which_costume == SPHERE_HIGH_ROPE) {
		start_matrix() ;
		translate(pos) ;
		sphere(size.x) ;
		stop_matrix() ;
	} else if (which_costume == TETRAHEDRON_ROPE) {
		start_matrix() ;
		translate(pos) ;
		tetrahedron((int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == BOX_ROPE) {
		start_matrix() ;
		translate(pos) ;
		box(size) ;
		stop_matrix() ;
	} 



		else if (which_costume == TETRAHEDRON_LINE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		polyhedron("TETRAHEDRON","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == CUBE_LINE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		polyhedron("CUBE","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == OCTOHEDRON_LINE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		polyhedron("OCTOHEDRON","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == RHOMBIC_COSI_DODECAHEDRON_SMALL_LINE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		polyhedron("RHOMBIC COSI DODECAHEDRON SMALL","LINE", (int)size.x) ;
		stop_matrix() ;
	} else if (which_costume == ICOSI_DODECAHEDRON_LINE_ROPE) {
		start_matrix() ;
		translate(pos) ;
		polyhedron("ICOSI DODECAHEDRON","LINE", (int)size.x) ;
		stop_matrix() ;
	}

	else if(which_costume < 0) {
		start_matrix() ;
		translate(pos) ;
		for(int i = 0 ; i < costume_pic_list.size() ; i++) {
			Costume_pic p = costume_pic_list.get(i) ;
			if(p.ID == which_costume) {
				if(p.type == 1) {
					PImage img_temp = p.img.copy() ;
					if(size.x == size.y ) {
						img_temp.resize((int)size.x, 0) ;
					} else if (size.x != size.y) {
						img_temp.resize((int)size.x, (int)size.y) ;
					}
					image(img_temp, 0, 0) ;
					break ;
				} else if(p.type == 2) {
					Vec2 scale = Vec2(1) ;
					if(size.x == size.y) {
            scale = Vec2(size.x / p.svg.width(), size.x / p.svg.width()) ;
					} else {
						scale = Vec2(size.x / p.svg.width(), size.y / p.svg.height()) ;
					}
					
					p.svg.scaling(scale) ;
					p.svg.draw() ;
					break ;
				}
				
			}
		}
		stop_matrix() ;
	}
}









// ANNEXE COSTUME
// CROSS
void cross_2(Vec3 size) {
	float ratio_cross = .3 ;
	float scale_cross = (size.x + size.y + size.z) *.3 ;
	float small_part = scale_cross *ratio_cross ;

	box(size.x, small_part, small_part) ;
	box(small_part, size.y, small_part) ;
}


void cross_3(Vec3 size) {
	float ratio_cross = .3 ;
	float scale_cross = (size.x + size.y + size.z) *.3 ;
	float small_part = scale_cross *ratio_cross ;
   
	box(size.x, small_part, small_part) ;
	box(small_part, size.y, small_part) ;
	box(small_part, small_part, size.z) ;
}