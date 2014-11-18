import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AsteroidsGame extends PApplet {

SpaceShip ship;
Star [] backgroundStars;
ArrayList <Asteroid> rocks= new ArrayList<Asteroid>();
float x1, x2, y1, y2;
public void setup() 
{
  size (800, 800);
  strokeWeight(1);
  stroke(100);
  background(0);
  ship= new SpaceShip();
  backgroundStars= new Star[200];
  for (int i=0; i<backgroundStars.length; i++)
  {
    backgroundStars[i]=new Star();
  }
  rocks= new ArrayList<Asteroid>();
  for (int i=0; i<10; i++)
  {
    rocks.add(new Asteroid());
  }
}



public void draw() 
{
  fill(0);
  rect(0, 0, width, height);
  ship.show();
  ship.move();
  ship.rotate(3, -3);
  for (int i=0; i<backgroundStars.length; i++) //stars
  {
    backgroundStars[i].show();
  }
  for (int i=0; i<rocks.size(); i++) //asteroids
  {
    rocks.get(i).show();
    rocks.get(i).move();
    rocks.get(i).rotate(2);
    float d=dist(rocks.get(i).getX(), rocks.get(i).getY(), ship.getX(), ship.getY());
    if(d<30)
    {
      rocks.remove(i);
    }
  }
  if (keyPressed==true && keyCode==UP) //ship 
  {
    ship.accelerate(.1f);
  } else if (keyPressed==true && keyCode==DOWN)
  {
    ship.accelerate(-0.1f);
  }
}



class Star
{
  int x, y;
  Star()
  {
    x=(int)(Math.random()*width);
    y=(int)(Math.random()*height);
  }
  public void show()
  {
    stroke(234, 219, 102);
    strokeWeight(1.75f);
    point(x, y);
  }
}



class SpaceShip extends Floater  
{   
  SpaceShip()
  {
    corners=3;  //the number of corners, a triangular floater has 3   
    xCorners=new int[corners];
    yCorners=new int[corners];
    xCorners[0]=15;
    yCorners[0]=0;
    xCorners[1]=-11;
    yCorners[1]=9;
    xCorners[2]=-11;
    yCorners[2]=-9;
    myColor=color(255,255,0);   
    myCenterX=width/2;
    myCenterY=height/2;
    myDirectionX=.15f;
    myDirectionY=.15f; //holds x and y coordinates of the vector for direction of travel   
    myPointDirection=Math.random()*360;
  }

  public void rotate (int nDegreesOfRotation, int nDegreesOfRotation2)   
  {     
    //rotates the floater by a given number of degrees
    if (keyPressed==true && keyCode==RIGHT)
    {  
      myPointDirection+=nDegreesOfRotation;
    }
    if (keyPressed==true && keyCode==LEFT)
    {  
      myPointDirection+=nDegreesOfRotation2;
    }
  }  

  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for (int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated, yRotatedTranslated);
    }   
    endShape(CLOSE);
    if(keyPressed==true && key==ENTER)
    {
    myCenterX=(int)(Math.random()*width);
    myCenterY=(int)(Math.random()*height);
    myDirectionX=0;
    myDirectionY=0;   
    myPointDirection=Math.random()*360;
    }
    // if(keyPressed==true && key==SHIFT)//shooting code
    // {
    //   int x=2;
    //   for(int i=0; i<100; i++)
    //   {
    //     point(xRotatedTranslated+x, yRotatedTranslated+x); //find how to shoot in direction// figure out code above
    //   }
    // }
  }

  

  public void setX(int x) {
    myCenterX=x;
  }  
  public int getX() {
    return (int)myCenterX;
  }   
  public void setY(int y) {
    myCenterY=y;
  }   
  public int getY() {
    return (int)myCenterY;
  }   
  public void setDirectionX(double x) {
    myDirectionX=x;
  }   
  public double getDirectionX() {
    return myDirectionX;
  }   
  public void setDirectionY(double y) {
    myDirectionY=y;
  }   
  public double getDirectionY() {
    return myDirectionY;
  }   
  public void setPointDirection(int degrees) {
    myPointDirection=degrees;
  }   
  public double getPointDirection() {
    return myPointDirection;
  }
}



class Asteroid extends Floater
{
  int rockSize;
  Asteroid()
  {
    rockSize=(int)(Math.random()*3)+1;
    corners=5;    
    xCorners=new int [corners];   
    yCorners=new int [corners]; 
    xCorners[0]=0*rockSize;
    yCorners[0]=10*rockSize;
    xCorners[1]=10*rockSize;
    yCorners[1]=8*rockSize;
    xCorners[2]=8*rockSize;
    yCorners[2]=-9*rockSize;
    xCorners[3]=-8*rockSize;
    yCorners[3]=-8*rockSize;
    xCorners[4]=-11*rockSize;
    yCorners[4]= 6*rockSize;
    myColor=color(255);   
    myCenterX=Math.random()*width;
    myCenterY=Math.random()*height;    
    myDirectionX=(Math.random()*4)-2;
    myDirectionY=(Math.random()*4)-2;
    myPointDirection=Math.random()*360;
  }
public void setX(int x) {
    myCenterX=x;
  }  
  public int getX() {
    return (int)myCenterX;
  }   
  public void setY(int y) {
    myCenterY=y;
  }   
  public int getY() {
    return (int)myCenterY;
  }   
  public void setDirectionX(double x) {
    myDirectionX=x;
  }   
  public double getDirectionX() {
    return myDirectionX;
  }   
  public void setDirectionY(double y) {
    myDirectionY=y;
  }   
  public double getDirectionY() {
    return myDirectionY;
  }   
  public void setPointDirection(int degrees) {
    myPointDirection=degrees;
  }   
  public double getPointDirection() {
    return myPointDirection;
  }
}


abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if (myCenterX >width)
    {     
      myCenterX = 0;
    } else if (myCenterX<0)
    {     
      myCenterX = width;
    }    
    if (myCenterY >height)
    {    
      myCenterY = 0;
    } else if (myCenterY < 0)
    {     
      myCenterY = height;
    }
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for (int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated, yRotatedTranslated);
    }   
    endShape(CLOSE);
  }
} 

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AsteroidsGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
