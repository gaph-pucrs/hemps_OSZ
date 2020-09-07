 
 //Retorna Zona segura 
 int get_static_SZ(){
	int appID;
	int xi = 255, yi = 255, xf = 0, yf = 0;

	appID = app_id_counter-1;		// ver se é o atual ou o próximo

#if MAX_STATIC_TASKS
	for(int i=0; i<MAX_STATIC_TASKS; i++){
		if ((static_map[i][0] >> 8) ==  appID){
			if ((static_map[i][1] >> 8) < xi)  // menor X
				xi = (static_map[i][1] >> 8);

			if ((static_map[i][1] & 0XFF) < yi) // menor Y
				yi = (static_map[i][1] & 0XFF);

			if ((static_map[i][1] >> 8) > xf)  // maior X
				xf = (static_map[i][1] >> 8);

			if ((static_map[i][1] & 0XFF) > yf) // maior Y
				yf = (static_map[i][1] & 0XFF);
	
		}
	}
#endif
	if(xi != 255){
		shape_index = 0;
		shapes[0].excess = 0;
		shapes[0].X_size = xf - xi + 1;
		shapes[0].Y_size = yf - yi + 1;
		shapes[0].position = (shapes[0].X_size << 24)|(shapes[0].Y_size << 16) | (xi << 8) | yi;
		shapes[0].used = 1; //Bug --nome
		shapes[0].cut = -1;
		shapes[0].processors = shapes[0].X_size * shapes[0].Y_size;
//		puts(">>>> Appid "); puts(itoa(appID)); 
//		puts("\n    xi: "); puts(itoh(xi));
//		puts("\n    yi: "); puts(itoh(yi));
//		puts("\n    xf: "); puts(itoh(xf));
//		puts("\n    yf: "); puts(itoh(yf));
//		puts("\n    position: "); puts(itoh(shapes[0].position));
//		puts("\n");
		return shapes[0].position;
	}

	return 0;	
}