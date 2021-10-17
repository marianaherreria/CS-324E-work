// creates grid

class Grid {
    float cWidth, cHeight;
    int numRows, numCols;
    PVector topLeft;

    Grid(float cwidth, float cheight, int cols, int rows, PVector topleft){
        this.cWidth = cwidth;
        this.cHeight = cheight;
        this.numRows = rows;
        this.numCols = cols;
        this.topLeft = topleft;
    }
    // calculates screen coordinates from grid coordinates
    PVector gridToXY(int col, int row, boolean center){
        PVector xy = new PVector(col*this.cWidth, row*this.cHeight);
        xy.add(this.topLeft);
        if(center) xy.add(this.cWidth/2, this.cHeight/2);
        return xy;
    }
    // calculates grid coordinates from screen coordinates
    PVector xyToGrid(float x, float y){
        PVector gridPos = new PVector(round(x/this.cWidth), round(y/this.cHeight));
        if(gridPos.x >= numCols || gridPos.y >= numRows) return null;
        return gridPos;
    }
    // draws the grid
    void display(){
        pushMatrix();
        stroke(255);
        noFill();
        translate(this.topLeft.x, this.topLeft.y);
        for(int i = 0; i < this.numCols; i++){
            for(int j = 0; j < this.numRows; j++){
                rect(i*this.cWidth, j*this.cHeight, this.cWidth, this.cHeight);
            }
        }
        popMatrix();
    }
}
