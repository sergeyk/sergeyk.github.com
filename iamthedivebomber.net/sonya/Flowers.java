import processing.core.*; import java.util.Random; import java.applet.*; import java.awt.*; import java.awt.image.*; import java.awt.event.*; import java.io.*; import java.net.*; import java.text.*; import java.util.*; import java.util.zip.*; public class Flowers extends PApplet {
Random r;

/////////////
final int WIDTH = 300;
final int HEIGHT = 300;
final int num_flowers_avg = 14;
final int num_flowers_range = 11;
// STEM:
final int stem_x = WIDTH/2;
final int stem_y = 7*HEIGHT/8;
final int stem_color = color(21,120,24,160);
final int x_displacement_avg = 0;
final int x_displacement_range = WIDTH/6;
final int y_displacement_avg = 3*HEIGHT/5;
final int y_displacement_range = HEIGHT/10;
final int x_shift_avg = 0;
final int x_shift_range = WIDTH/25;
final int y_shift_range = y_displacement_avg/9;
// HEAD:
final int head_size_avg = HEIGHT/15;
final int head_size_range = 3*head_size_avg/10;
////////////

IndividualFlower[] flowers;
float sin_i;
float sin_w;

public void setup() {
  size(300,300); // need manual input to export correctly
  smooth();
  frameRate(26);
  r = new Random();
  createBouquet();
}

public void createBouquet() {
  // change up first sway direction
  sin_i = (r.nextInt(2) == 0) ? (0) : (PI);
  // make the flowers
  int num_flowers = randomRange(num_flowers_avg, num_flowers_range);
  flowers = new IndividualFlower[num_flowers];
  for (int i = 0; i < flowers.length; i++)
    flowers[i] = new IndividualFlower();
}

public void draw() {
  background(0);
  // update the sine wave (for swaying flowers)
  sin_i = (sin_i + PI/384) % TWO_PI;
  sin_w = sin(sin_i);
  // draw the flowers
  for (int i = 0; i < flowers.length; i++)
    flowers[i].draw();
  
  //if (frameCount % 10 == 0) System.out.println("Framerate: " + frameRate);
}

public void mousePressed() {
  createBouquet();
}

public int randomRange(int avg, int range) {
  return (avg + r.nextInt(2*range) - range);
}

public float randomRange(float avg, int range) {
  return (avg + r.nextInt(2*range) - range);
}

public class IndividualFlower {

  ///////////////////////
// STEM:
float x_displacement;
float orig_x_displacement;
float y_displacement;
float orig_y_displacement;
float x_shift;
float y_shift_avg; // depends on y_displacement
float y_shift;
float orig_x_shift;
float orig_y_shift;
// HEAD:
int head_color;
float head_x;
float head_y;
int head_size;
// PETALS: (depend on head size)
int petal_color;
int num_petals_avg;
int num_petals_range;
int petal_size;
int num_petals;
float petals_indiv_rotate;
// SWAYING:
float effect_degree;
///////////////////////

// generate all the unique variables
public IndividualFlower() {
  orig_x_displacement = randomRange(x_displacement_avg, x_displacement_range);
  orig_y_displacement = randomRange(y_displacement_avg, y_displacement_range);
  x_shift = x_shift_avg + r.nextInt(2*x_shift_range) - x_shift_range;
  y_shift_avg = orig_y_displacement/3;
  orig_y_shift = randomRange(y_shift_avg, y_shift_range);
  head_size = randomRange(head_size_avg, head_size_range);
  head_color = color(r.nextInt(256), r.nextInt(256), r.nextInt(256));
  num_petals_avg = 3*head_size/4;
  num_petals_range = head_size/2;
  num_petals = randomRange(num_petals_avg, num_petals_range);
  petal_size = head_size;
  petal_color = color(r.nextInt(256), r.nextInt(256), r.nextInt(256));
  petals_indiv_rotate = r.nextFloat() * PI;
  effect_degree = 1.0f*(head_size_range - head_size + head_size_avg)/(head_size_avg-head_size_range);
  // the formula above assigns a rank between 0 and 2*range, according to head size,
  // and divides it by avg-range to get a value not quite from 0 to 1 but more bunched in the middle
}

// updates some variables to make the flower appear to sway
public void update() {
  x_displacement = orig_x_displacement + effect_degree*x_displacement_range*sin_w;
  y_displacement = orig_y_displacement - effect_degree*abs(y_displacement_range*sin_w/3);
  y_shift = orig_y_shift + effect_degree*y_shift_range*sin_w/2;
}

// update, then render the flower
public void draw() {
  // update the flower (to make it sway)
  update();
  
  // draw the stem
  pushMatrix();
  translate(stem_x,stem_y);
  stroke(stem_color);
  noFill();
  bezier(0,0, 0,0, -x_shift,-y_shift, -x_displacement,-y_displacement);
  
  // draw the head
  head_x = -x_displacement;
  head_y = -y_displacement;
  pushMatrix();
  translate(head_x,head_y);
  fill(head_color);
  stroke(0);
  ellipseMode(CENTER);
  ellipse(0,0,head_size,head_size);
  
  // draw petals
  fill(petal_color);
  ellipseMode(CORNER);
  // rotate a random amount for individuality
  rotate(petals_indiv_rotate);
  for (int i = 0; i < num_petals; i++) {
    ellipse(petal_size/4, 0-petal_size/4, petal_size, petal_size/3);
    rotate(TWO_PI/num_petals);
  }
  popMatrix();
  popMatrix();
}

}

  static public void main(String args[]) {     PApplet.main(new String[] { "Flowers" });  }}