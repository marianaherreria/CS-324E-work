Consumable s1, s2;
PacMan pacManGame, pacManLogo;
Ghost ghost1, ghost2;
Grid grid;
PImage logo;

PVector[] fruits;

void setup() {
  size(800, 800);
  background(255);

  frameRate(6);
  logo = loadImage("pac-man-logo.png");

  grid = new Grid(50, 50, 
                  int(width/50)-1, int((height-logo.height)/50)-1, 
                  new PVector(25, logo.height + 25));
  
  // Consumables
  fruits = new PVector[]{new PVector(grid.numCols-2, 1), new PVector(1, grid.numRows-2)};
  PVector f1Pos = grid.gridToXY(round(fruits[0].x), round(fruits[0].y), true);
  PVector f2Pos = grid.gridToXY(round(fruits[1].x), round(fruits[1].y), true);

  PVector p = new PVector(0,10);
  PVector s = new PVector(0,1);

  s2 = new Consumable(f1Pos.x, f1Pos.y, p, 0.1, color(200, 30, 100)); // can change location, speed, and color
  s1 = new Consumable(f2Pos.x, f2Pos.y, s, 0.1, color(219,35,35));

  // Pac-Man
  PVector left = new PVector(-1, 0);
  PVector right = new PVector(1, 0);
  PVector up = new PVector(0, -1);
  PVector down = new PVector(0, 1);
  PVector[] path = new PVector[38];
  for(int i = 0; i < 12; i++){
    path[i] = right;
    path[i+19] = left;
  }
  for(int i = 0; i < 7; i++){
    path[i+12] = down;
    path[i+31] = up;
  }

  pacManGame = new PacMan(1, 1, 45, 45, new PVector(1, 0), path, true);
  pacManLogo = new PacMan(295, 105, 125, 125, new PVector(1, 0), new PVector[]{}, false);

  // Ghosts
  ghost1 = new Ghost(grid.numCols/2+1, grid.numRows/2+3, -1, 0, color(255, 0, 0), true);
  ghost2 = new Ghost(0, grid.numRows/2+4, 0, 1, color(0, 255, 0), true);
}

void draw () {
  background(0);
  image(logo, 0, 0, width, logo.height);

  display();
  run();
}

// draws everything
void display(){
  grid.display();
  s1.display();
  s2.display();
  pacManGame.display(grid);
  pacManLogo.display(grid);
  ghost1.display(grid);
  ghost2.display(grid);
}

// updates all the objects
void run(){
  s1.bounce();
  s1.rotat();
  s2.bounce();
  s2.rotat();

  pacManGame.run(fruits);
  pacManLogo.run(null);

  ghost1.run(grid, pacManGame);
  ghost2.run(grid, pacManGame);
}

// returns true if the given number is within the given bounds
// this comparison was done enough times that a dedicated function was practical
boolean within(float n, float minBound, float maxBound, boolean inclusive){
  if(inclusive) return (n >= minBound && n <= maxBound);
  else return (n > minBound && n < maxBound);
}
