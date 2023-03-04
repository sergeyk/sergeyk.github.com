/**
 * Flowers 
 * by Sergey Karayev. 
 * 
 * Generated flowers swaying in a sine-wave wind.
 * Click on them to make a new bouquet. 
 * 
 * Updated 17 September 2007
 */

import java.util.Random;
Random r;

/////////////
final int WIDTH = 300;
final int HEIGHT = 300;
final int num_flowers_avg = 14;
final int num_flowers_range = 11;
// STEM:
final int stem_x = WIDTH/2;
final int stem_y = 7*HEIGHT/8;
final color stem_color = color(21,120,24,160);
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

void setup() {
  size(300,300); // need manual input to export correctly
  smooth();
  frameRate(26);
  r = new Random();
  createBouquet();
}

void createBouquet() {
  // change up first sway direction
  sin_i = (r.nextInt(2) == 0) ? (0) : (PI);
  // make the flowers
  int num_flowers = randomRange(num_flowers_avg, num_flowers_range);
  flowers = new IndividualFlower[num_flowers];
  for (int i = 0; i < flowers.length; i++)
    flowers[i] = new IndividualFlower();
}

void draw() {
  background(0);
  // update the sine wave (for swaying flowers)
  sin_i = (sin_i + PI/384) % TWO_PI;
  sin_w = sin(sin_i);
  // draw the flowers
  for (int i = 0; i < flowers.length; i++)
    flowers[i].draw();
  
  //if (frameCount % 10 == 0) System.out.println("Framerate: " + frameRate);
}

void mousePressed() {
  createBouquet();
}

int randomRange(int avg, int range) {
  return (avg + r.nextInt(2*range) - range);
}

float randomRange(float avg, int range) {
  return (avg + r.nextInt(2*range) - range);
}
