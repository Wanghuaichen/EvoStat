// This is the size and shape of a stack of n nyodimium mags
mirrorside1 = 15;
mirrorside2 = 15;
mirrorthick = 2;

magradius = 5;
//magradius = 4.6; // sensor: slip-on oversized magradius
melexis = 4.8;   // digital temp sensor

magthick = 3;
nummagnets = 6;

module magnet(height)
{   cylinder(r=magradius,h=height,center=true); }

module mymirror(thick)
{ cube([mirrorside1,mirrorside2,mirrorthick],center=true); }

module magnetcup(n)
{
	height = nummagnets*1.0;
	cupside = 2*magradius + 4;
	difference() {
		translate([0,2.3,0])cube([mirrorside1+2.5,mirrorside2-2,height+4],center=true);
		translate([0,3,2])
          magnet(height+1); //bigger for subtraction
  }
}

module mirrorcup()
{	
  thick = 6;

 rotate([0,0,-90])
  difference() {
   cube([mirrorside1+4,mirrorside2+2.5,thick],center=true);
   translate([0.25,0,2]) 
      mymirror(thick+3); // thicker for subtraction

   translate([4+mirrorside1/2,0,2-mirrorside1])
   rotate([0,45,0])
     cube([mirrorside1+8,mirrorside1+8,mirrorside1+8],center=true);
 translate([8,0,-2]) 
    rotate([0,45,0]) cube([5,20,8],center=true);
}
}

module mirrorframe(thick)
{	
  difference() {
   cube([30,30,thick],center=true);
   translate([-6.9,-6.9,0]) 
      cube([30,30,thick+2],center=true);
   translate([-12,-12,0])
       rotate([0,0,45])
         cube([44,44,thick+2],center=true);
  }
}

module half() {

translate([1.8,1.8,-0.25]) mirrorframe(12);

translate([9.5,0.5,2.5]) 
   rotate([0,-90,0])
      mirrorcup();
translate([16.2,-11.6,2.5])
   rotate([0,-90,45])
      magnetcup(4);
}

module jarwall() {
  difference() {
     cube([40,40,120],center=true);
	  translate([40,0,0])
	     cylinder(r=50,h=120,center=true,$fn=64);
	   }
}
	
module assembly() {
	half();
   translate([-1.4,1.4,0])
    rotate([0,0,-90])
      mirror([1,0,0])
          half();
}

module mirrordevice() {

  difference() {
   assembly();
   translate([6,6,3]) rotate([90,0,45]) jarwall();
  }
}

module sensordevice() {
     translate([26,30,4]) cube([5,62,34],center=true);
     translate([-26,30,4]) cube([5,62,34],center=true);
     translate([0,31,19]) cube([48,60,4],center=true);
     translate([ 17,7,-4]) cube([12,2,12],center=true);
     translate([-17,7,-4]) cube([12,2,12],center=true);

difference() {
	  translate([0,0,4]) cube([48,20,34], center=true);
translate([0,0,-4]) union() {
     translate([17,0,0]) rotate([90,0,0]) magnet(22);
     translate([-17,0,0]) rotate([90,0,0]) magnet(22);
     translate([0,0,14]) rotate([90,0,0]) cylinder(r=melexis,h=30,center=true);

     translate([5,0,0]) rotate([90,0,0]) cylinder(r=3.2,h=30,center=true);
     translate([-5,0,0]) rotate([90,0,0]) cylinder(r=2.1,h=30,center=true);
	     translate([-5,-4,0]) rotate([90,0,0]) cylinder(r1=1,r2=9,h=18,center=true);
    
 //    translate([14,8,14]) rotate([90,0,0]) cylinder(r=1.4,h=10,center=true);
  //   translate([-14,8,14]) rotate([90,0,0]) cylinder(r=1.4,h=10,center=true);


	  translate([20,-52,0])
       rotate([0,90,0])
	     cylinder(r=50,h=120,center=true,$fn=64);
   } // end union
 }
}


//rotate([0,180,0]) sensordevice();
translate([0,-15,-2]) rotate([0,0,-135])
                  mirrordevice();
//mirrorcup();
//half();
//assembly();