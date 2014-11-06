SpaceShip ship;
Star [] backgroundStars;
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
}
public void draw() 
{
  fill(0);
  rect(0, 0, width, height);
  ship.show();
  ship.move();
  ship.rotate(3, -3);
  for (int i=0; i<backgroundStars.length; i++)
  {
    backgroundStars[i].show();
  }
  if (keyPressed==true && keyCode==UP)
  {
    ship.accelerate(.1);
  } else if (keyPressed==true && keyCode==DOWN)
  {
    ship.accelerate(-0.1);
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
    strokeWeight(1.75);
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
    xCorners[0]=10;
    yCorners[0]=0;
    xCorners[1]=-6;
    yCorners[1]=4;
    xCorners[2]=-6;
    yCorners[2]=-4;
    myColor=color(255);   
    myCenterX=width/2;
    myCenterY=height/2;
    myDirectionX=.15;
    myDirectionY=.15; //holds x and y coordinates of the vector for direction of travel   
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
  public void show()
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
    if (keyPressed==true && key==ENTER)
    {
      myCenterX=(int)(Math.random()*width);
      myCenterY=(int)(Math.random()*height);
      myDirectionX=0;
      myDirectionY=0;
      myPointDirection=(int)(Math.random()*360);
    }
    //    if(keyPressed==true && key=='w')
    //    {
    //      stroke(255);
    //      line((int)myCenterX-10,(int)myCenterY,(int)myCenterX-18,(int)myCenterY);
    //    }
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

