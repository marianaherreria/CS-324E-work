// creates ghosts class 

class Ghost {
    PVector pos, dir;
    color c;
    boolean isChasing;

    Ghost(float x, float y, float dx, float dy, color c, boolean chasing){
        // fills in object fields with constructor parameters
        this.pos = new PVector(x, y);
        this.dir = new PVector(dx, dy);
        this.c = c;
        this.isChasing = chasing;
    }
    Ghost(PVector p, PVector d, color c, boolean chasing){
        // fills in object fields with constructor parameters
        this.pos = p;
        this.dir = d;
        this.c = c;
        this.isChasing = chasing;
    }

    // runs updates the object based on Pac-Man's state
    void run(Grid grid, PacMan pm){
        // update position
        this.pos.add(this.dir);
        // chases if pacman is not powered up, runs if he is
        this.isChasing = !pm.poweredUp;
        // calculate unit vector pointing toward Pac-Man
        PVector ghostToPacman = PVector.sub(pm.pos, this.pos);
        ghostToPacman.normalize();
        // points vectors in opposite direction if running
        if(!this.isChasing) ghostToPacman.mult(-1);

        // pathfinds based on direction unit vector
        // goes in the cardinal direction with the greatest magnitude if possible
        // trys other directions if not
        if(abs(ghostToPacman.x) >= abs(ghostToPacman.y)){
            int newX = round(ghostToPacman.x / abs(ghostToPacman.x));
            if(within(newX + round(this.pos.x), 0, grid.numCols-1, true)){
                this.dir.x = newX;
                this.dir.y = 0;
            } else {
                this.dir.x = 0;
                int newY;
                if (ghostToPacman.y != 0) {
                    newY = round(ghostToPacman.y / abs(ghostToPacman.y));
                } else {
                    newY = round(this.pos.y - grid.numRows/2);
                    newY = round(newY / abs(newY));
                }
                if(within(newY + round(this.pos.y), 0, grid.numRows-1, true)) this.dir.y = newY;
                else this.dir.y = -newY;
            }
        } else {
            int newY = round(ghostToPacman.y / abs(ghostToPacman.y));
            if(within(newY + round(this.pos.y), 0, grid.numRows-1, true)){
                this.dir.y = newY;
                this.dir.x = 0;
            } else {
                this.dir.y = 0;
                int newX;
                if (ghostToPacman.x != 0) {
                    newX = round(ghostToPacman.x / abs(ghostToPacman.x));
                } else {
                    newX = round(this.pos.x - grid.numCols/2);
                    newX = round(newY / abs(newX));
                }
                if(within(newX + round(this.pos.x), 0, grid.numCols-1, true)) this.dir.x = newX;
                else this.dir.x = -newX;
            }
        }
    }

    // draws the ghost by calling other draw functions
    void display(Grid grid){
        pushMatrix();
        PVector centerVector = grid.gridToXY(round(this.pos.x), round(this.pos.y), true);
        translate(centerVector.x, centerVector.y);
        this.drawBody();
        this.drawFace();

        popMatrix();
    }
    // draws the body
    void drawBody(){
        noStroke();
        if(this.isChasing) fill(this.c);
        else fill(10, 10, 255);

        arc(0, 0, 50, 50, PI, TWO_PI);
        rect(-25, 0, 50, 20);
        triangle(-25, 20, -25, 25, -20, 20);
        triangle(-20, 20, -15, 25, -10, 20);
        triangle(-10, 20, -5, 25, 0, 20);
        triangle(0, 20, 5, 25, 10, 20);
        triangle(10, 20, 15, 25, 20, 20);
        triangle(20, 20, 25, 25, 25, 20);

    }
    // draws the eyes
    void drawFace(){
        pushMatrix();
        translate(this.dir.x*3, this.dir.y*3);
        noStroke();
        fill(255);
        ellipse(-10, -5, 10, 15);
        ellipse(10, -5, 10, 15);
        translate(this.dir.x*2, this.dir.y*2);
        fill(0);
        ellipse(-10, -5, 6, 8);
        ellipse(10, -5, 6, 8);
        popMatrix();
    }
}
