// Ball cup style rod end for delta arm joints

// Outer diameter of ball cup
od=13; // 0.1

// Ball diameter with any clearance
bd=9.58; // 0.01

// Sleeve diameter
sd=11; // 0.1

// Arm diameter
ad=6; // 0.01

// Arm offset from ball center
ao=10; // 0.1

// Sleeve length over arm
sl=20; // 0.1

// Cutout slope offset
cso=3.25; // 0.05

// Lower coverage angle
lca=55; // 0.1

// Joint angle (for visualization only)
ja=-35; // 0.1

// Enable visualization of joint
mock=false;

//bd=9.48;

module torus(r1,r2) {
rotate_extrude()
translate([r1,0,0])
circle(r=r2);
}

module seam_profile(r1,r2) {
	translate([r1,0]) scale([1/2,1,1]) translate([r2*0.9,0]) {
		circle(r=r2);
		difference() {
			translate([-r2,0]) square([2*r2,4*r2],center=true);
			for (i=[-1,1])
			translate([0,i*2*r2]) circle(r=r2);
		}
	}
}

module seam_cut(r1,r2) {
	intersection() {
		scale([1/3,1,1])
		rotate([0,90,0])
		rotate_extrude() seam_profile(r1,r2);
		translate([0,od,0]) cube(2*od,center=true);
	}
	translate([0,0.4,-bd/8])
	scale([1/3,1,1])
	rotate(90)
	linear_extrude(height=od,convexity=3)
	seam_profile(r1,r2);
}

module ballcupend_base()
difference() {
	union() {
		//sleeve shaft
		translate([0,od/2,0])
		rotate([-90,0,0]) {
			cylinder(d=sd,h=ao+sl-od/2-0.6);
			translate([0,0,ao+sl-od/2-0.6])
			cylinder(d1=sd,d2=sd-1.2,h=0.6);
		}

		//outer side of cup
		hull() {
			sphere(d=od);
			translate([0,13,0]) sphere(d=sd-2);
		}
	}

	// flat bottom/top
	translate([0,0,-2*sd-sd/2*sin(lca)]) cube([200,200,4*sd],center=true);
	translate([0,0,+2*sd+sd/2-sd/11]) cube([200,200,4*sd],center=true);

	// cup interior
	sphere(d=bd);
	// safety retaining zone without contact
	translate([0,0,-bd/8])
	cylinder(d=bd+0.8,h=2*od);

	// cutout to place seam
	seam_cut(bd/2,1);

	// cutout to avoid elephant foot contact
	cylinder(d=bd/2,h=2*od,center=true);

	// cutout for range of motion clearance
	clearance_cut();

	// hole for arm
	armhole();
}

module clearance_cut() {
	translate([0,-od+cso,od]) cube(2*od,center=true);
	translate([0,cso,13])
	scale([1,(ao-cso)/6.75,1])
	scale([1,.7,1])
	rotate([0,90,0]) cylinder(d=2*13,h=2*od,center=true);
}

module armhole() {
	translate([0,ao,0])
	difference() {
		rotate([90,0,180])
		linear_extrude(height=2*sl)
		hull() {
			circle(d=ad);
			// peak to make overhang printable and
			// to bleed epoxy during assembly
			translate([0,ad/2+0.2])
			rotate(45)
			square(1,center=true);
		}
		// taper end of peak to avoid piercing
		// the surface near ball
		translate([0,0,ad/2+0.2])
		rotate([-35,0,0])
		translate([0,-ad/2,])
		cube([2*od,ad,ad],center=true);
	}
	translate([0,ao+sl-0.6,0])
	rotate([90,0,180])
	cylinder(d1=ad,d2=ad+4,h=2);
}

module spring_hook()
difference() {
	translate([0,ao+5,sd/2-sd/11])
	hull() {
		translate([0,0,-1]) cube([sd*cos(asin(9/11)),12,2],center=true);
		translate([0,0,1.25]) cube([sd*cos(asin(9/11))*.5,4,2],center=true);
	}

	translate([0,ao+5,sd/2-sd/11])
	scale([1,1,1])
	translate([0,0,6/2])
	rotate([90,0,0])
	torus(6/2,0.8);

	for (i=[0,1])
	translate([0,2*(ao+5)*i,0])
	mirror([0,i,0])
	clearance_cut();

	armhole();
}

module ballcupend() union() {
	ballcupend_base();
	spring_hook();
}

if (mock)
// mockup of ball/barbell to check interference
%
rotate([ja,0,0])
union() {
	sphere(d=bd-0.02);
	translate([0,0,0]) cylinder(d=6,h=50);
}

ballcupend();

$fs=.2;
$fa=5;
