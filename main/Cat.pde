class Cat {

boolean debug = true;
PVector position, target;
PImage faceCurrent, cat01, cat02, cat03, cat04;
float margin = 50;
 int foodChoice;

boolean isBothered = false;
int botheredMarkTime = 0;
int botheredTimeout = 3000;
float botheredSpread = 5;

boolean isBlinking = false;
int blinkMarkTime = 0;
int blinkTimeout = 4000;
int blinkDuration = 250;

boolean isHunting = false;

float triggerDistance1 = 100;
float triggerDistance2 = 5;
float movementSpeed = 0.02;


Cat(float x, float y) { 
 
  position = new PVector(x,y);
  pickEscapeTarget();
  
    cat01 = loadImage("cat01.png");
    cat01.resize(cat01.width/3, cat01.height/3);
    cat02 = loadImage("cat02.png");
    cat02.resize(cat01.width, cat01.height);
    cat03 = loadImage("cat03.png");
    cat03.resize(cat01.width, cat01.height);
    cat04 = loadImage("cat04.png");
    cat04.resize(cat01.width, cat01.height);
    
    faceCurrent = cat01;
  }

void update() {
    PVector mousePos = new PVector(mouseX, mouseY);
    isBothered = position.dist(mousePos) < triggerDistance1;
 
if (isBothered) {
      isHunting = false;
      botheredMarkTime = millis();
      faceCurrent = cat02; 
      if (position.dist(target) < triggerDistance2) {
        pickEscapeTarget();
      }
    } else if (!isBothered && millis() > botheredMarkTime + botheredTimeout) {
      if (!isBlinking && millis() > blinkMarkTime + blinkTimeout) {
        isBlinking = true;
        blinkMarkTime = millis();
      } else if (isBlinking && millis() > blinkMarkTime + blinkDuration) {
        isBlinking = false;
      }
  
      if (isBlinking) {
        faceCurrent = cat04; 
      } else {
        faceCurrent = cat03; 
      }   
      
      if (!isHunting) {
        pickFoodTarget();
        isHunting = true;
      }
    } else if (!isBothered && millis() > botheredMarkTime + botheredTimeout/6) {
      faceCurrent = cat01; 
    }
  
    if (isBothered || isHunting) {
      position = position.lerp(target, movementSpeed);
    }
    
    if (isHunting && position.dist(target) < 5) {
      foods[foodChoice].alive = false; 
      pickFoodTarget();
    }
    
    position.y += sin(millis()) / 2;
  }
  
  
void draw() {    
    ellipseMode(CENTER);
    rectMode(CENTER);
    imageMode(CENTER);
  
    image(faceCurrent, position.x, position.y);

  }
  
  void run() {
    update();
    draw();
  }
  
  void pickEscapeTarget() {
    target = new PVector(random(margin, width-margin), random(margin, height-margin));
  }
  
  void pickFoodTarget() {
    foodChoice = int(random(foods.length));
    if (foods[foodChoice].alive) {
      target = foods[foodChoice].position;
    }
  }
  
}
