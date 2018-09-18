import controlP5.*;
ControlP5 cp5;

//Reference: https://processing.org/examples/bouncybubbles.html
float spring = 0.01;
float gravity = 0.01;
float friction = -0.9;
int indexX = 0;
int indexY = 0;
int[][] array = {
                 {50, 43, 45, 57, 39, 75, 17}, //2002 male
                 {50, 57, 55, 43, 61, 25, 83}, //2002 female
                 {49, 57, 56, 54, 40, 75, 12}, //2004 male
                 {51, 43, 44, 46, 60, 25, 88}, //2004 female
                 {50, 58, 61, 63, 42, 75, 10}, //2006 male
                 {50, 42, 39, 37, 58, 25, 90}, //2006 female
                 {50, 59, 54, 60, 43, 72, 10}, //2008 male
                 {50, 41, 46, 40, 57, 28, 90}, //2008 female
                 {49, 59, 62, 62, 41, 70, 10}, //2010 male
                 {51, 41, 38, 38, 59, 30, 90}, //2010 female
                 {49, 58, 66, 60, 42, 69, 10}, //2012 male
                 {51, 42, 34, 40, 58, 31, 90}, //2012 female
                 {50, 57, 67, 62, 46, 67, 10}, //2014 male
                 {50, 43, 33, 38, 54, 33, 90}, //2014 female
                 {48, 57, 60, 59, 45, 64, 10}, //2016 male
                 {52, 43, 40, 41, 55, 36, 90}  //2016 female
                };

Ball[] femaleBalls;
Ball[] maleBalls;

int numFemales;
int numMales;

color femaleColor;
color maleColor;

RadioButton radioButton;
Slider slider;

void setup() {
  size(1200, 600);
  cp5 = new ControlP5(this);
  femaleColor = color(255, 204, 0, 100);
  maleColor = color(153, 27, 30, 100);
  
  radioButton = cp5.addRadioButton("radioButton")
         .setPosition(10,370)
         .setSize(40,20)
         .setColorForeground(color(120))
         .setColorActive(color(240))
         .setColorLabel(color(0))
         .setItemsPerRow(1)
         .setSpacingColumn(100)
         .addItem("Total",0)
         .addItem("BUAD",1)
         .addItem("Physical Science",2)
         .addItem("Math",3)
         .addItem("Biological Science",4)
         .addItem("Engineering",5)
         .addItem("Education",6)
         ;
     
  for(Toggle t:radioButton.getItems()) {
       t.getCaptionLabel().setColorBackground(color(100,80));
       t.getCaptionLabel().getStyle().moveMargin(-7,0,0,-3);
       t.getCaptionLabel().getStyle().movePadding(7,0,0,3);
       t.getCaptionLabel().getStyle().backgroundWidth = 100;
       t.getCaptionLabel().getStyle().backgroundHeight = 13;
     }
  
  slider = cp5.addSlider("yearSlider")
    .setPosition(10,550)
    .setWidth(200)
    .setColorTickMark(0)
    .setColorLabel(0)
    .setCaptionLabel("Year")
    .setRange(2002,2016) // values can range from big to small as well
    .setNumberOfTickMarks(8)
    .setSliderMode(Slider.FLEXIBLE)
    ;   
  
  numFemales = array[indexX][indexY];
  numMales = array[indexX + 1][indexY];

  femaleBalls = new Ball[numFemales];
  maleBalls = new Ball[numMales];

  for (int i = 0; i < numFemales; i++) {
    femaleBalls[i] = new Ball(random(width), random(height), random(30, 70), i, femaleBalls, true, numFemales);
  }
  for (int i = 0; i < numMales; i++) {
    maleBalls[i] = new Ball(random(width), random(height), random(30, 70), i, maleBalls, false, numMales);
  }
  
  noStroke();
}

void update(float input){
  //User changed year
  if(input > 1000){
    indexX = (int)input - 2002;
  }
  
  //User changed major
  else if(input < 1000){
    indexY = (int)input;
    if(indexY == 0){ //total
      femaleColor = color(255, 204, 0, 100);
      maleColor = color(153, 27, 30, 100);
    }
    else if(indexY == 1){ //BUAD
      femaleColor = color(244, 244, 66, 100);
      maleColor = color(255, 134, 68, 100);
    }
    else if(indexY == 2){ //physical science
      femaleColor = color(252, 58, 67, 100);
      maleColor = color(67, 106, 249, 100);
    }
    else if(indexY == 3){ //Math
      femaleColor = color(173, 56, 252, 100);
      maleColor = color(57, 203, 252, 100);
    }
    else if(indexY == 4){ //biological science
      femaleColor = color(252, 242, 55, 100);
      maleColor = color(118, 226, 45, 100);
    }
    else if(indexY == 5){ //engineering
      femaleColor = color(224, 47, 212, 100);
      maleColor = color(174, 109, 255, 100);
    }
    else if(indexY == 6){ //education
      femaleColor = color(252, 151, 63, 100);
      maleColor = color(47, 224, 209, 100);
    }
  }
  
  numMales = array[indexX][indexY];
  numFemales = array[indexX + 1][indexY];
  femaleBalls = new Ball[numFemales];
  maleBalls = new Ball[numMales];

  for (int i = 0; i < numFemales; i++) {
    femaleBalls[i] = new Ball(random(width), random(height), random(30, 70), i, femaleBalls, true, numFemales);
  }
  for (int i = 0; i < numMales; i++) {
    maleBalls[i] = new Ball(random(width), random(height), random(30, 70), i, maleBalls, false, numMales);
  }
}

void draw() {
  background(255);
  
  noStroke();
  
  fill(175, 175, 175, 160);
  rect(10,220,95,130);
  fill(0);
  text("Gender", 12,230);
  
  fill(femaleColor);
  ellipse(55,260,50,50);
  
  fill(maleColor);
  ellipse(55,320,50,50);
    
  if(dist(mouseX,mouseY,55,260)<25){
    fill(0);
    text("female",mouseX-5,mouseY-5);
  }
  
  if(dist(mouseX,mouseY,55,320)<25){
    fill(0);
    text("male",mouseX-5,mouseY-5);
  }
  
  fill(femaleColor);
  for (Ball ball : femaleBalls) {
    ball.collide();
    ball.move();
    ball.display();  
  }
  fill(maleColor);
  for (Ball ball : maleBalls) {
    ball.collide();
    ball.move();
    ball.display();  
  }
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isFrom(radioButton)) {
    update(theEvent.getValue());
    println(theEvent.getValue());
  }
  else if(theEvent.isFrom(slider)){
    update(theEvent.getValue());
    println(theEvent.getValue());
  }
}

class Ball {
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  boolean isGravityDown;
  Ball[] others;
  int numBalls;
 
  Ball(float xin, float yin, float din, int idin, Ball[] oin, boolean grav, int numGenderBalls) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
    isGravityDown = grav;
    numBalls = numGenderBalls;
  } 
  
  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }   
  }
  
  void move() {
    if(isGravityDown){
      vy -= gravity;
    }
    else{
      vy += gravity;
    }
    
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction; 
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
}