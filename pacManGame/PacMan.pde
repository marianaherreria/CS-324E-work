// Creates pac man class

class PacMan {
  // fields that define the objects
  PVector pos, dir;
  PVector[] path;
  int pathIndex, counter;
  boolean onGrid, mouthOpen, poweredUp;
  float angle;
  float w, h;
  // the shape for drawing
  PShape pacManDisplay;
  PShape pacManBody;
  PShape pacManEye;
  PShape pacManMouth;
  
  PacMan(float x, float y, float w, float h, PVector direction, PVector[] path, boolean onGrid) {
    // fill in object fields from constructor parameters
    this.pos = new PVector(x, y);
    this.dir = direction;
    this.path = path;
    this.onGrid = onGrid;
    this.mouthOpen = false;
    this.pathIndex = this.path.length-1;
    this.angle = 0;
    this.poweredUp = false;
    this.w = w;
    this.h = h;
    // creating PShape to draw Pac-Man
    this.pacManDisplay = createShape(GROUP);
    noStroke();
    fill(244, 196, 48); // pac man yellow
    this.pacManBody = createShape(ARC, 0, 0, this.w, this.h, PI/6, 11*PI/6); // , PIE
    this.pacManMouth = createShape(ARC, 0, 0, this.w, this.h, -PI/6, PI/6);
    fill(0);
    this.pacManEye = createShape(ELLIPSE, -this.w/5, -this.h/5, this.w/5, this.h/5);
    this.pacManDisplay.addChild(pacManBody);
    this.pacManDisplay.addChild(pacManEye);
    
  }
  
  //draws Pac-Man at its current position
  void display(Grid grid) {
    pushMatrix();
    PVector centerVector;
    // converts from grid coords to sketch coords if it is in a grid
    if(this.onGrid) centerVector = grid.gridToXY(round(this.pos.x), round(this.pos.y), true);
    // uses normal position coordinates otherwise
    else centerVector = this.pos;
    // moves and rotates origin to Pac-Man's center
    translate(centerVector.x, centerVector.y);
    rotate(this.angle);
    // draws
    shape(this.pacManDisplay);
    if(this.mouthOpen) shape(this.pacManMouth);
    popMatrix();
  } 
  
  void run(PVector[] fruits){
    // flips mouth from open to closed or closed to open
    this.mouthOpen = !this.mouthOpen;
    // moves Pac-Man along its set path if it is in the grid
    if(this.onGrid){
      // limits power up time
      if(this.poweredUp){
        this.counter++;
        if(counter >= 8) this.poweredUp = false;
      }
      // powers up Pac-Man if a fruit is encountered
      for(PVector fruit: fruits){
        if(round(this.pos.x-fruit.x) == 0 && round(this.pos.y-fruit.y) == 0){
          this.poweredUp = true;
          this.counter = 0;
          break;
        }
      }
      // updates Pac-Man's position and direction
      this.pathIndex = (this.pathIndex + 1) % this.path.length;
      this.dir = this.path[this.pathIndex];
      this.pos.add(this.dir);
    }
    // determine which direction Pac-Man should face
    this.angle = PVector.angleBetween(new PVector(1, 0), this.dir);
    PVector normal = this.dir.cross(new PVector(1, 0));
    if(normal.z > 0) angle *= -1;
  }
  
}
