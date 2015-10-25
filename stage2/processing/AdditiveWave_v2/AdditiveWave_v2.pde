/*--------------------*/
//import g4p_controls.*;
/*--------------------*/

/*--------------------*/
//GSlider sdr;
//int rValue = 0;
/*--------------------*/

int xspacing = 8;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave
int maxwaves = 5;   // total # of waves to add together

float theta = 0.0;
float[] amplitude = new float[maxwaves];   // Height of wave
float[] dx = new float[maxwaves];          // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues;                           // Using an array to store height values for the wave (not entirely necessary)

void setup() {
  size(640, 360);

  /*---------------------------------------------*/
  //sdr = new GSlider(this, 0, 0, 250, 30, 15);
  //sdr.setLimits(0, 0, 255);
  /*---------------------------------------------*/
  
  frameRate(30);
  colorMode(RGB, 255, 255, 255, 100);
  w = width + 32;

  for (int i = 0; i < maxwaves; i++) {
    amplitude[i] = random(10, 30);
    float period = random(100, 300); // How many pixels before the wave repeats
    dx[i] = (TWO_PI / period) * xspacing;
  }

  yvalues = new float[w/xspacing];
}

void draw() {
  //background(rValue, 0, 0);
  background(0);
  calcWave();
  renderWave();
}

/*
void keyPressed()
{
  switch(key)
  {
  case 'w':
    rValue++;
    //sdr.setValue();
  case 's':
    rValue--;
    break;
  }

  println(rValue);
}
*/

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.05;

  // Set all height values to zero
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = 0;
  }

  // Accumulate wave height values
  for (int j = 0; j < maxwaves; j++) {
    float x = theta;
    for (int i = 0; i < yvalues.length; i++) {
      // Every other wave is cosine instead of sine
      if (j % 2 == 0)  yvalues[i] += sin(x)*amplitude[j];
      else yvalues[i] += cos(x)*amplitude[j];
      x+=dx[j];
    }
  }
}

void renderWave() {
  // A simple way to draw the wave with an ellipse at each location
  noStroke();
  fill(255, 50);
  ellipseMode(CENTER);
  for (int x = 0; x < yvalues.length; x++) {
    ellipse(x*xspacing, width/4+yvalues[x], 16, 16);
  }
}

/*
public void handleSliderEvents(GValueControl slider, GEvent event) { 
  if (slider == sdr)  // The slider being configured?
    rValue = sdr.getValueI();
}
*/