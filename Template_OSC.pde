Tracker myTracker;
Triangle triangle = new Triangle();
Triangle triangleMouth2 = new Triangle(); 
Triangle triangleMouth1 = new Triangle();
Triangle triangleEyes2 = new Triangle();
Arm arm = new Arm();

float pixelSize = 0; 
float widthonescreen = 0; 
float screenWidthFloat = 0; 
float screenHeightFloat = 0; 
float angleArm = 180;
float coinMovement = 0; 

boolean triggerMouthMotionStart = false; 
boolean triggerCoinMotion = false;
boolean triggerArmsDown = false; 
float counterCoinMotion = 0; 
float counterArmsDown = 0; 
float fadeinFont = 0; 
float coinGravity = 15; 

void setup() {
  fullScreen(FX2D);  // actual screen size 1080*1920*2;
  //fullScreen(FX2D, SPAN); use this for displaying on multiple screens
  ScreenSetup screen = new ScreenSetup(); // important for scaling the screen for the correct aspect ratio
  myTracker = new Tracker();// important for getting the tracking information from an external application
  rectMode(CENTER);
  fill(255);
  widthonescreen = width/2;
  screenWidthFloat = width;
  screenHeightFloat = height;
  pixelSize = widthonescreen / 47;
};

void draw() {
  noCursor();
  PVector TargetPos = myTracker.getTarget();
  if (TargetPos.x*width <= width/2) {
    fadeinFont = map(TargetPos.x*width, width/16, width*0.4, 255, 0);
  } else {
    fadeinFont = map(TargetPos.x*width, width*0.6, width-width/16, 0, 255);
  }
  if (TargetPos.x*width >= width/4.5 && TargetPos.x*width <= width-width/4.5) {
    triggerCoinMotion = true; 
    if (angleArm > 75) {
      angleArm -= 7;
    } else {
      angleArm = 75;
    }
  } else {
    triggerCoinMotion = false; 
    if (triggerArmsDown == true) {
      if (angleArm > 180) {
        angleArm = 180;
        triggerArmsDown = false;
      } else {
        angleArm += 7;
      }
    }
  }
  if (triggerCoinMotion == true) {
    counterCoinMotion++;
  } else {
    if (counterCoinMotion <= 90) {
      counterCoinMotion = 0; 
      triggerArmsDown = true;
    }
  }
  if (counterCoinMotion > 90) {
    if ((coinMovement < height/3.4 && triggerCoinMotion == true) || coinMovement > 0) {
      if (coinGravity >= 50) {
        coinGravity = 50;
      } else {
        coinGravity++;
      }
      coinMovement += coinGravity;
      triggerArmsDown = false;
    }
    if (coinMovement >= height/3.4) {
      if (counterArmsDown > 25) {
        triggerArmsDown = true; 
        counterArmsDown = 0; 
        coinMovement = 0;
        counterCoinMotion = 0; 
        coinGravity = 0;
      } else {
        triggerArmsDown = false; 
        counterArmsDown++; 
        coinMovement = height/3.4;
      }
    }
  }
  background(255);
  fill(0); 
  noStroke(); 
  rectMode(CORNER);
  ellipseMode(CENTER);
  fill(#808080);
  circle(width/2-width/20, 0-height/50+coinMovement, width/50);
  circle(width/2+width/20, 0-height/50+coinMovement, width/50);
  fill(0);
  ghost1(); 
  ghost2();
  rectMode(CENTER);
  fill(0, 0, 0, fadeinFont); 
  rect(width/4, height-(height/16), width/5, width/5/7.48);
  rect(width/2+width/4, height-(height/16), width/5, width/5/7.48);
  fill(255, 0, 0);
  // screen split line
  strokeWeight(2);
  stroke(0, 0, 0, 0);
  line(width/2, 0, width/2, height);
  //if (frameCount % 120 == 1  ) println("FPS"+frameRate); // for checking the performance of your code
};

void ghost1() {
  // Arms
  pushMatrix(); 
  translate(width/4, height/3); 
  rotate(radians(angleArm));
  arm.render(width/3.85);
  popMatrix();
  // Body
  pushMatrix(); 
  translate(0.25*width, 0);
  fill(0);
  triangle.render(height, false, false); 
  popMatrix();
  // Mouth
  pushMatrix(); 
  translate(width/4.5, height/6); 
  rotate(radians(270)); 
  fill(255);
  triangleMouth1.render(width/9, true, false); 
  popMatrix();
}
void ghost2() {
  // Arms
  pushMatrix(); 
  translate(width-width/4, height/3); 
  scale(-1, 1);
  rotate(radians(angleArm));
  arm.render(width/3.85);
  popMatrix();
  // Body
  pushMatrix(); 
  translate(0.75*width, 0);
  fill(0);
  triangle.render(height, false, false); 
  popMatrix();
  // Mouth
  pushMatrix(); 
  translate(width-width/4.5, height/6); 
  rotate(radians(90));
  fill(255);
  triangleMouth2.render(width/9, true, true); 
  popMatrix();
}
