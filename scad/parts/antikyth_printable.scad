//
// Antikythera printable parts (param + tolerance-friendly)
// Units: mm
//
// SPDX-License-Identifier: MIT

$fn = 180;

// --------- What to generate ----------
PART = "a1";  // "a1","a2","a3","a4","a5","a6","a7","a8","a9","a10","a12","all"

// --------- Print tolerance controls ----------
/*
  Typical starting points:
  - FDM (0.4 nozzle): hole_oversize=0.25..0.40, clearance=0.20..0.35
  - Resin:            hole_oversize=0.10..0.20, clearance=0.10..0.20
*/
hole_oversize = 0.30;     // added to DIAMETER of holes
clearance     = 0.25;     // general fit clearance (diameter/width)
chamfer       = 0.40;     // quick chamfer amount for printed edges (visual + assembly help)

// -----------------------------
// Helpers
// -----------------------------
module obround_2d(L, W) {   // slot / stadium shape
    W2 = max(W, 0.01);
    L2 = max(L, W2);
    r = W2/2;
    hull() {
        translate([-(L2/2 - r), 0]) circle(r=r);
        translate([ (L2/2 - r), 0]) circle(r=r);
    }
}

module rounded_rect_2d(w, h, r) {
    r2 = min(r, min(w,h)/2);
    hull() {
        translate([ w/2 - r2,  h/2 - r2]) circle(r=r2);
        translate([-w/2 + r2,  h/2 - r2]) circle(r=r2);
        translate([ w/2 - r2, -h/2 + r2]) circle(r=r2);
        translate([-w/2 + r2, -h/2 + r2]) circle(r=r2);
    }
}

module quick_chamfer_cyl(d, h, ch) {
    // simple chamfer approximation (good enough for prints)
    union() {
        translate([0,0,ch]) cylinder(d=d, h=max(h-2*ch, 0.01));
        cylinder(d1=max(d-2*ch,0.01), d2=d, h=ch);
        translate([0,0,h-ch]) cylinder(d1=d, d2=max(d-2*ch,0.01), h=ch);
    }
}

module hole_cyl(d, h) { cylinder(d=d + hole_oversize, h=h); }

// -----------------------------
// a10: Disk (Ø111, thickness 3.0) + center slot (Ø9.0 with R1.50 ends)
// -----------------------------
module part_a10(
    d_disk=111,
    t=3.0,
    slot_end_r=1.50,
    slot_len=9.0 + 2*1.50  // a reasonable interpretation: obround with Ø9 “waist” and R1.50 ends
) {
    difference() {
        cylinder(d=d_disk, h=t);
        translate([0,0,-0.5])
            linear_extrude(height=t+1.0)
                obround_2d(L=slot_len, W=2*slot_end_r);
    }
}

// -----------------------------
// a9: Axle (main Ø14, step Ø9, overall height 46.4, with small features)
// This matches the visible key dims: Ø14, Ø9, 32, 11.4, 46.4, and a Ø2 cross hole marker.
// -----------------------------
module part_a9(
    d_main=14.0,
    len_main=32.0,
    d_step=9.0,
    len_step=11.4,
    len_total=46.4,
    cross_hole_d=2.0
) {
    // derive tail length to hit overall
    tail = max(len_total - (len_main + len_step), 0.0);

    difference() {
        union() {
            // main body
            quick_chamfer_cyl(d_main - clearance, len_main, chamfer);

            // step
            translate([0,0,len_main])
                quick_chamfer_cyl(d_step - clearance, len_step, chamfer);

            // tail (keep it same as step unless you want it different)
            if (tail > 0.01)
                translate([0,0,len_main+len_step])
                    quick_chamfer_cyl(d_step - clearance, tail, chamfer);
        }

        // cross hole near the top section (approx placement)
        translate([0,0,len_main + len_step*0.55])
            rotate([90,0,0])
                hole_cyl(cross_hole_d, d_main*2);
    }
}

// -----------------------------
// a8: Pins x2 (Ø3.0 x ~11, with small radius ends)
// -----------------------------
module part_a8(d=3.0, L=11.0) {
    hull() {
        translate([0,0,0]) sphere(d=d);
        translate([L,0,0]) sphere(d=d);
    }
}

// -----------------------------
// a2: Washer (Ø16 OD, Ø10 ID, thickness 0.7)
// -----------------------------
module part_a2(d_od=16.0, d_id=10.0, t=0.7) {
    difference() {
        cylinder(d=d_od, h=t);
        translate([0,0,-0.5]) hole_cyl(d_id, t+1.0);
    }
}

// -----------------------------
// a5: Washer (Ø12 OD, Ø8 ID, thickness 1.5)
// -----------------------------
module part_a5(d_od=12.0, d_id=8.0, t=1.5) {
    difference() {
        cylinder(d=d_od, h=t);
        translate([0,0,-0.5]) hole_cyl(d_id, t+1.0);
    }
}

// -----------------------------
// a6: Tube (Ø11.8 OD, ID = R4.0 => Ø8.0, height 17) + side windows + U-slot
// Windows sizes from drawing: slot height 8.8, slot width 6.4-ish shown; keep param.
// -----------------------------
module part_a6(
    d_od=11.8,
    d_id=8.0,
    h=17.0,
    window_w=3.0,
    window_h=8.8,
    window_inset=0.8,
    u_slot_w=3.0,
    u_slot_depth=6.4
) {
    difference() {
        // tube body
        difference() {
            quick_chamfer_cyl(d_od, h, chamfer);
            translate([0,0,-0.5]) hole_cyl(d_id + clearance, h+1.0);
        }

        // two side windows opposite each other
        for (ang=[0,180]) {
            rotate([0,0,ang])
                translate([d_od/2 - window_inset, 0, (h-window_h)/2])
                    rotate([0,90,0])
                        linear_extrude(height=2.2, center=true)
                            rounded_rect_2d(window_h, window_w, r=window_w/2);
        }

        // U-slot from bottom
        translate([0,0,-0.5])
            linear_extrude(height=u_slot_depth+0.5)
                obround_2d(L=d_id + 1.0, W=u_slot_w + clearance);
    }
}

// -----------------------------
// a4 / a7: Block with rounded corners + bore + top posts
// a4 dimensions shown: width 16, height 32.2, corner R8, bore Ø10.
// Posts Ø2.9, top details 3.0 and 2.0 tall segments shown.
// We'll keep as a printable interpretation.
// -----------------------------
module part_a4(
    w=16.0,
    H=32.2,
    t=8.0,          // thickness not clearly shown; adjust if needed
    corner_r=8.0,
    bore_d=10.0,
    bore_z=17.6,    // from drawing (centerline region)
    post_d=2.9,
    post_h=3.0,
    post_spacing=8.0
) {
    difference() {
        linear_extrude(height=t)
            rounded_rect_2d(w, H, corner_r);

        // through-bore (front-to-back)
        translate([0,0,bore_z])
            rotate([90,0,0])
                hole_cyl(bore_d + clearance, H + 2);
    }

    // top posts
    translate([0,0,t])
    for (sx=[-1,1]) {
        translate([sx*post_spacing/2, H/2 - 2.50, 0])
            cylinder(d=post_d - clearance, h=post_h);
    }
}

// a7 looks like a variant; use same geometry unless you later differentiate
module part_a7() { part_a4(); }

// -----------------------------
// a1: Gear (printable placeholder: outer/root radii from drawing + simple tooth bumps)
// Outer radius ~14.1, root radius ~12.4, thickness 2.0.
// Tooth count is not specified clearly -> param default.
// -----------------------------
module part_a1(teeth=56, r_outer=14.1, r_root=12.4, t=2.0, bore_r=2.5) {
    difference() {
        linear_extrude(height=t)
            polygon(points=[
                for (i=[0:teeth*2-1]) let(
                    a=i*180/teeth,
                    rr=(i%2==0)?r_outer:r_root
                ) [ rr*cos(a), rr*sin(a) ]
            ]);

        translate([0,0,-0.5]) hole_cyl(bore_r*2 + clearance, t+1.0);
    }
}

// -----------------------------
// a3: Small cam-like part (placeholder solid so you can print/test fit)
// -----------------------------
module part_a3(d=9.8, h=16.8, flat=2.0) {
    // simple cylinder with a flat
    difference() {
        cylinder(d=d, h=h);
        translate([d/2 - flat, -d, -0.5]) cube([d, 2*d, h+1.0]);
    }
}

// -----------------------------
// a12: Link plate (printable interpretation from drawing)
// Hole Ø3, spacing 19.5, end radii R5/R2.5, thickness ~1.0
// -----------------------------
module part_a12(th=1.0, hole_d=3.0, center_dist=19.5, r_left=5.0, r_right=2.5) {
    difference() {
        linear_extrude(height=th)
            hull() {
                translate([0,0]) circle(r=r_left);
                translate([center_dist,0]) circle(r=r_right);
            }

        translate([0,0,-0.5]) hole_cyl(hole_d, th+1.0);
        translate([center_dist,0,-0.5]) hole_cyl(hole_d, th+1.0);
    }
}

// -----------------------------
// Part selector
// -----------------------------
module render_part(name) {
    if (name=="a1") part_a1();
    else if (name=="a2") part_a2();
    else if (name=="a3") part_a3();
    else if (name=="a4") part_a4();
    else if (name=="a5") part_a5();
    else if (name=="a6") part_a6();
    else if (name=="a7") part_a7();
    else if (name=="a8") part_a8();
    else if (name=="a9") part_a9();
    else if (name=="a10") part_a10();
    else if (name=="a12") part_a12();
    else if (name=="all") {
        // layout for batch exporting (spaced out)
        translate([-40,  0,0]) part_a10();
        translate([ 40,  0,0]) part_a1();
        translate([-40, 40,0]) part_a4();
        translate([  0, 40,0]) part_a6();
        translate([ 40, 40,0]) part_a9();
        translate([-40,-40,0]) part_a2();
        translate([  0,-40,0]) part_a5();
        translate([ 40,-40,0]) part_a12();
        translate([ 60,-65,0]) part_a8();
        translate([ 70,-65,0]) part_a8();
    }
}

render_part(PART);
