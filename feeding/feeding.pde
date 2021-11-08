import shiffman.box2d.*;
//import box2d.;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

class Box  {
 

  Body body;
  float x,y;
  float w,h;
  
 
  Box(float x_, float y_) {
    x = x_;
    y = y_;
    w = 16;
    h = 16;
 

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(mouseX,mouseY));
    body = box2d.createBody(bd);
 

    PolygonShape ps = new PolygonShape();

    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2dW, box2dH);
 
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    fd.density = 1;

    fd.friction = 0.3;
    fd.restitution = 0.5;
 

    body.createFixture(fd);
 } 
 
  void display() {
    
    fill(175);
    stroke(0);
    rectMode(CENTER);
    //rect(x,y,w,h);

    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
 
    pushMatrix();

    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
}



ArrayList<Box> boxes;
Box2DProcessing box2d;
float circle;
float radius;
float speed = 5;
float x;
float y;
 
void setup() {
  size(400,600);
  boxes = new ArrayList<Box>();
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  circle = 10;
  radius = 30;
  
}
 
void draw(){
  background(255);
  box2d.step();
  
  circle = circle + speed;
  
  if (circle > width){
    speed = -5;
  }
  if (circle < 0){
    speed = 5;
  }
  stroke(0);
  fill(175);
  ellipse(circle,550,60,60);
  if(dist(mouseX,mouseY,circle,550) < radius){
    //Box.killBody();
  }
  if(mousePressed){
    Box p = new Box(mouseX ,mouseY);
    boxes.add(p);
}

  for(Box b: boxes){
    b.display();
    
  }
  //box2d.killBody();
}
