PImage img;

int numCats = 2;
int numFoods = 20;

Cat[] Cats = new Cat[numCats];
Food[] foods = new Food[numFoods];

void setup() { 
  size(900, 600, P2D);
  
    img = loadImage("BG.jpg");
  
  for (int i=0; i<Cats.length; i++) {
    Cats[i] = new Cat(random(width), random(height));
  }
  
  for (int i=0; i<foods.length; i++) {
    foods[i] = new Food(random(width), random(height));
  }
}

void draw() {
  background(127);
  
  image(img, 450, 300, 900,600);
  
  for (int i=0; i<foods.length; i++) {
    foods[i].run();
  }
  
  for (int i=0; i<Cats.length; i++) {
    Cats[i].run();
  }
}
