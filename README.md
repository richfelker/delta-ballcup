# Ball-cup style arm joint for delta robots

This is a printable, parametric OpenSCAD design for ball-cup style
delta joints, usable on delta-kinematics 3D printers or other delta
robots or similar parallel mechanisms. It maintains a parallelogram
configuration between a pair of arms using spring tension to hold the
cups against precision-machined balls.

To use these, you will need material for the arms, springs, and balls
for the cups to interface with. In the default configuration, the cup
is sized for [the barbells sold by
SeeMeCNC](https://www.seemecnc.com/products/cnc-machined-ball-joint-kit),
but it can be adjusted as needed. Recommended springs to go with these
barbells (50 mm ball spacing) are 0.8 mm wire diameter by 6 mm coil
diameter by 25 mm length; these parameters may need adjustment for
different ball spacing. Recommended arm material is 6 mm diameter
pultruded carbon fiber tubes.

Some history and motivation for the ball cup style approach can be
found in [this archived article by
SublimeLayers](https://web.archive.org/web/20240227153252/https://www.sublimelayers.com/2017/04/delta-arm-joint-musings.html).
I designed these printable cups due to the original sources for this
part no longer being available, and have used them successfully on the
M45 delta printer.


## Printing information

The ball cups should be printed with a thin layer height (0.1 mm
recommended) and 100% infill. Solid infill works better (gives more
rigidity) in this case than increasing the number of perimeters until
the part is solid. Seam should be placed (either manually or with
"rear" or concealment settings) in the groove at the back of the cup,
so that any print inaccuracies around the seam do not affect the
mechanical interface with the ball.

Print material should be rigid and not subject to creep, since the
ball cups will be under a continuous, strong spring force once
installed.

Abrasive materials should not be used, so as not to destroy the balls.


## Installation

Ball cups should be attached to arms with epoxy, one at a time on a
jig to ensure that all arms have as close to identical length as
possible.

The design dimensions have the center of the ball cup exactly 10 mm
from where the tube would bottom out in the sleeve. Tubes should be
cut 21 mm shorter than the desired length between ball centers to
ensure the assembly does not exceed design length.


## Maintenance

White Lightning Clean Ride bicycle chain lubricant, or a similar
wax-based lubricant, is recommended inside the cups for smooth
operation and reducing wear.

If it becomes necessary to replace a ball cup, the rod can be savaged
for reuse by removing the ball cup with sharp plastic-cutting tools
and scraping off remaining epoxy.
