// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 201
// Box2DProcessing example

// Example demonstrating revolute joint

import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;


ArrayList<Boundary> boundaries;

// A reference to our box2d world
Box2DProcessing box2d;

// An object to describe a Windmill (two bodies and one joint)
Windmill windmill;

// An ArrayList of particles that will fall on the surface
ArrayList<Particle> particles;


void setup() {
  size(1080,720);
    background(255,45,32);
  smooth();

  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

                                                    // Make the windmill at an x,y location ruleta localizacion 
  windmill = new Windmill(200,500);

                             // Create the empty list
  particles = new ArrayList<Particle>();

}

// Click the mouse to turn on or off the motor
void mousePressed() {
  windmill.toggleMotor();
}

void draw() {
  background(56,45,111);
///

boundaries = new ArrayList<Boundary>();                              //      lineas pared

boundaries.add(new Boundary(width/5,height-5,width/2-50,10,0));
  boundaries.add(new Boundary(3*width/4,height-30,width/2-40,10,0));
  boundaries.add(new Boundary(width-5,height/2,10,height,0));

  ////////////// caja

boundaries.add(new Boundary(width-1,height/1,5,height,10));
  
  
  
  
  for (Boundary wall: boundaries) {
    wall.display();
  }


///                                                      /////////////////////////////////////////////77
  if (random(1) < 0.1) { 
    float sz = random(2,8);
    particles.add(new Particle(random(150,400),-20,sz));
  }


  // We must always step through time!
  box2d.step();

  // Look at all particles
  for (int i = particles.size()-1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.display();
    // Particles that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) {
      particles.remove(i);
    }
  }

  // Draw the windmill
  windmill.display();
  
  String status = "OFF";
  if (windmill.motorOn()) status = "ON";
  
  fill(0);
  text("Click mouse to toggle motor.\nMotor: " + status,100,270);
  

}
