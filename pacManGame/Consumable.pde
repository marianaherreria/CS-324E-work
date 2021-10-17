float angle; 

class Consumable { 
  PShape cherry;
  PShape part1;
  PShape part2;
  PShape rec;
  float x, y, r, rpm;
  PVector speed;
  PShape stem;
  PShape stem2;
  color c;
  float y_cons;

  Consumable(float x, float y, PVector speed, float rpm, color c) {
    this.x = x;
    this.y = y;
    this.speed = speed;
    this.rpm = rpm;
    this.c = c;
    y_cons = y; // set a constant of y passed for bounce later
  }
  // draws the consumable
  void display() {
    cherry = createShape(GROUP);
    fill(c);
    PShape part1 = createShape(ELLIPSE, x-12.5, y, 25, 25); // creating cherry
    PShape part2 = createShape(ELLIPSE, x+12.5, y, 25, 25);
    PShape stem = createShape(LINE, x-12.5, y-10, x+10, y-25);
    PShape stem2 = createShape(LINE, x+12.5, y-10, x+10, y-25);
    cherry.addChild(part1);
    cherry.addChild(part2);
    cherry.addChild(stem);
    cherry.addChild(stem2); // combining parts of cherry to form one cherry
    shape(cherry); // display cherry
  }
  
  void bounce() { //moves cherry up and down
    x += speed.x;
    if (y > y_cons + speed.y*2){ // sets how much cherry moves
    y -= speed.y; // move up if at bottom limit
    } else {
      y += speed.y; // move down if at top limit
    }
  }
     
  void rotat() { // rotate bonus sign section of consumable around cherry
    angle += rpm;
    pushMatrix();
    translate(x,y);
    stroke(237,230,19);
    rotate(angle);
    fill(c);
    rect(30,30,30,5); // bonus object
    text("Bonus", 30, 30); 
    popMatrix();
  }
    
}
