// Recreated the scene I built for the lighting hands-on
// Added shininess, ambience, and specularity modifications

PImage myImg;

void setup() {
  size(600, 600, P3D); 
  noStroke();
  myImg = loadImage("galaxy.jpg");
  // setting up a camera to look at objects (2 speheres and a box)
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, -1, 0);
}

void draw() {
  background(38, 70, 83);
  
  fill(0, 51, 200);
  
  // Create a PImage and apply a texture to it
  // Experiment with texture mode and texture wrapping options
  textureMode(NORMAL); 
  textureWrap(REPEAT);
  texture(myImg);
  image(myImg, 0, 0);
 
  lightSpecular(204, 204, 204); 
  specular(255, 255, 255);
 
  // create one of each: directional light, point light, spot light, ambient light
  directionalLight(210, 210, 210, -1, 0, 0.0);
  pointLight(255, 255, 255, 350, 350, 50);
  spotLight(255, 255, 255, 350, 350, 50, -1, 0, 0, HALF_PI, 1);
  ambientLight(102, 102, 102);
 
  pushMatrix();
  shininess(4.0);
  ambient(233, 196, 106);
  shininess(2.0);
  rotateY(0.5);
  box(200, 200, 50);
  popMatrix();
     
  translate(width/2, height/2, 0);
  ambient(244, 162, 97);
  shininess(2.0);
  sphere(175);

  lightSpecular(204, 40, 40); 
  specular(255, 0, 0);
 
  translate(width/2, height/2, 0);
  shininess(2.0);
  ambient(200, 40, 40);
  sphere(150);
  
  beginShape();
  vertex(40, 80, 0, 0);
  vertex(320, 20, 1, 0);
  vertex(380, 360, 1, 1);
  vertex(160, 380, 0, 1);
  endShape();
  

}
