global_settings{assumed_gamma 1.0}

#declare Lng=20;
#declare Lat=30;
#declare Tilt=0;
#declare Pers=0.1;
#declare Zoom=1;
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


#macro axis(a)
    union{
        object{Arrow(<0,0,0>,<1,0,0>,0.05) pigment{rgb<1,a,a>}}
        object{Arrow(<0,0,0>,<0,1,0>,0.05) pigment{rgb<a,1,a>}}
        object{Arrow(<0,0,0>,<0,0,1>,0.05) pigment{rgb<a,a,1>}}
    }
#end

axis(0.0)

object{axis(0.3) matrix<0.6970939965788908, 0.5173720698928652, 0.4963729457055868, -0.5982159802369158, 0.0380792679937661, 0.8004296410917356, 0.3952184217908565, -0.8549129257671982, 0.33604506905073556, 0.0, 0.0, 0.0>}

#declare Time = 3*clock;
#if(Time<1)
    #declare t1 = Time;
    #declare t2 = 0;
    #declare t3 = 0;
#elseif(Time<2)
    #declare t1 = 1;
    #declare t2 = Time-1;
    #declare t3 = 0;
#else
    #declare t1 = 1;
    #declare t2 = 1;
    #declare t3 = Time-2;
#end

object{
    axis(0.6)
    scale 1.001
    rotate x*-56.54878559530895*t1
    rotate y*45.80568256766892*t2
    rotate x*133.8133217639332*t3
}
