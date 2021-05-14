global_settings{assumed_gamma 1.0}

#declare Lng=20;
#declare Lat=30;
#declare Tilt=0;
#declare Pers=0.1;
#declare Zoom=0.55;
#declare LookAt=<0,0,0>;

#macro SCS(lng,lat) <cos(radians(lat))*cos(radians(lng)),cos(radians(lat))*sin(radians(lng)),sin(radians(lat))> #end
#declare AspectRatio=image_width/image_height;
#declare Z=SCS(Lng,Lat);
#declare X=vaxis_rotate(<-sin(radians(Lng)),cos(radians(Lng)),0>,Z,Tilt);
#declare Y=vcross(Z,X);
#if(Pers)
    #declare Loc=LookAt+SCS(Lng,Lat)/(Zoom*Pers);
    camera{
        perspective
        location Loc
        right -2*X*sqrt(AspectRatio)/Zoom
        up 2*Y/(sqrt(AspectRatio)*Zoom)
        direction Z/(Zoom*Pers)
        sky Y
        look_at LookAt
    }
    light_source{
        Loc
        color rgb<1,1,1>
    }
#else
    #declare Loc=SCS(Lng,Lat);
    camera{
        orthographic
        location Loc*100
        right -2*X*sqrt(AspectRatio)/Zoom
        up 2*Y/(sqrt(AspectRatio)*Zoom)
        sky Y
        look_at LookAt
    }
    light_source{
        SCS(Lng,Lat)
        color rgb<1,1,1>
        parallel
        point_at 0
    }
#end
background{rgb<1,1,1>}

#declare Empty=difference{sphere{0,1} sphere{0,2}};

#macro Sphere(a,r)
	#if(r=0)
		Empty
	#else
		object{sphere{a,abs(r)}}
	#end
#end

#macro Cylinder(a,b,r)
	#if(r=0)
		Empty
	#else
		object{cylinder{a,b,abs(r)}}
	#end
#end

#macro Cone(a,b,r)
	cone{a,abs(r),b,0}
#end

#macro Cone2(p1,r1,p2,r2)
	#local d=vlength(p2-p1);
	#local P1=p1-r1*(r2-r1)*vnormalize(p2-p1)/d;
	#local P2=p2-r2*(r2-r1)*vnormalize(p2-p1)/d;
	#local R1=sqrt(r1*r1-r1*r1*(r2-r1)*(r2-r1)/d/d);
	#local R2=sqrt(r2*r2-r2*r2*(r2-r1)*(r2-r1)/d/d);
	#if(r1*r2<0)
		union{
			cone{P1,R1,(R2*P1+R1*P2)/(R1+R2),0}
			cone{(R2*P1+R1*P2)/(R1+R2),0,P2,R2}
		}
	#else
		cone{P1,R1,P2,R2}
	#end
#end

#macro Arrow(a,b,r)
	union{
		difference{
			Cylinder(a,b,r)
			Cylinder(b-6*r*vnormalize(b-a),2*b-a,2*r)
		}
		Cone(b-6*r*vnormalize(b-a),b,2*r)
	}
#end

#macro Matrix(e1,e2,e3,p0)
	matrix<
	vdot(e1,x), vdot(e1,y), vdot(e1,z),
	vdot(e2,x), vdot(e2,y), vdot(e2,z),
	vdot(e3,x), vdot(e3,y), vdot(e3,z),
	vdot(p0,x), vdot(p0,y), vdot(p0,z)>
#end

#macro RotateMatrix(n,w,p0)
	translate -p0
	Matrix(vaxis_rotate(x,n,degrees(w)),vaxis_rotate(y,n,degrees(w)),vaxis_rotate(z,n,degrees(w)),p0)
#end

#macro axis(a)
    union{
        object{Arrow(<0,0,0>,<1,0,0>,0.05) pigment{rgb<1,a,a>}}
        object{Arrow(<0,0,0>,<0,1,0>,0.05) pigment{rgb<a,1,a>}}
        object{Arrow(<0,0,0>,<0,0,1>,0.05) pigment{rgb<a,a,1>}}
    }
#end

#declare D = 1.2;

object{
    union{
        object{Arrow(<-1,0,0>,<1,0,0>,0.02) pigment{rgb<1,0,0>}}
        object{Arrow(<0,-1,0>,<0,1,0>,0.02) pigment{rgb<0,1,0>}}
        object{Arrow(<0,0,-1>,<0,0,1>,0.02) pigment{rgb<0,0,1>}}
    }
    translate -X*D
}


#fopen MyFile "rot_x.txt" read
#declare M=60;
#declare e1=array[M];
#declare e2=array[M];
#declare e3=array[M];
#declare p=array[M];

#declare i=0;
#while(i<M)
    #read (MyFile,_e1)
    #read (MyFile,_e2)
    #read (MyFile,_e3)
    #read (MyFile,_p)
    #declare e1[i]=_e1;
    #declare e2[i]=_e2;
    #declare e3[i]=_e3;
    #declare p[i]=_p;
    #declare i=i+1;
#end

#declare N=frame_number-1;

// MRP Point
sphere{p[N],0.05 pigment{rgb<0,0,0>} translate -X*D}

// Unit Ball
sphere{0,1 pigment{rgbft<0.8,0.8,0.8,0.3,0.3>} translate -X*D}

object{axis(0.0) translate X*D}
object{axis(0.6)
    scale 1.001
    Matrix(e1[N],e2[N],e3[N],<0,0,0>)
    translate X*D
}



