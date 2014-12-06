SpaceShip ship;
Star [] backgroundStars;
ArrayList <Asteroid> rocks= new ArrayList <Asteroid>();
ArrayList <Bullet> bullets=new ArrayList <Bullet>();
ArrayList <Integer> numberShot=new ArrayList <Integer>();
boolean gameOver=false;
public void setup() 
{
  size (800, 800);
  strokeWeight(1);
  stroke(100);
  background(0);
  ship=new SpaceShip();
  bullets=new ArrayList <Bullet> ();
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
  for(int r=0; r<numberShot.size();r++)
  {
    numberShot.remove(r);
  }
}

void keyPressed()
{
  if(keyCode==32)
  {
    bullets.add(new Bullet(ship));
  }
  if(key=='r')
  {
    setup();
    gameOver=false;
  }
}



public void draw() 
{
  fill(0);
  rect(0, 0, width, height);
  ship.show();
  ship.move();
  ship.rotate(3, -3);
  for(int i=0; i<bullets.size(); i++)
  {
    bullets.get(i).show();
    bullets.get(i).move();
  }
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
    if(rocks.size()==1)
    {
     for (int z=0; z<10; z++)
      {
        rocks.add(new Asteroid());
      }
    }
    if(d<30)
    {
      rocks.remove(i);
      gameOver=true;
      ship.setDirectionX(0);
      ship.setDirectionY(0);
    }
  }
  for(int k=0; k<bullets.size(); k++)
  {
      if(bullets.get(k).getX()>width || bullets.get(k).getX()<0)
    {
      bullets.remove(k);
      break;
    }
      if(bullets.get(k).getY()>height || bullets.get(k).getY()<0)
    {
      bullets.remove(k);
      break;
    }
  }
  if (keyPressed==true && keyCode==UP) //ship 
  {
    ship.accelerate(.1);
  } else if (keyPressed==true && keyCode==DOWN)
  {
    ship.accelerate(-0.1);
  }

  //Game Over
  if(gameOver==true)
  {
    fill(255,0,0);
    textSize(50);
    textAlign(CENTER,BOTTOM);
    text("GAME OVER", width/2, height/2);
    textAlign(CENTER, TOP);
    textSize(20);
    text("Number of asteroids shot: " + numberShot.size(), width/2, height/2);
    fill(255,255,0);
    text("press 'r' to restart game", width/2, height/2+100);
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
    xCorners[0]=15;
    yCorners[0]=0;
    xCorners[1]=-11;
    yCorners[1]=7;
    xCorners[2]=-11;
    yCorners[2]=-7;
    myColor=color(255,255,0);   
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



class Bullet extends Floater{
  double dRadians;
  Bullet(SpaceShip theShip)
  {
    myColor=color(255,255,0);
    myCenterX=theShip.getX();
    myCenterY=theShip.getY();
    myPointDirection=theShip.getPointDirection();
    dRadians=myPointDirection*(Math.PI/180);
    myDirectionX=12*(Math.cos(dRadians))+theShip.getDirectionX();
    myDirectionY=12*(Math.sin(dRadians))+theShip.getDirectionY();
  }
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);                             
    ellipse((float)myCenterX,(float)myCenterY,2,2);
  }
   public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;
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
    rockSize=(int)(Math.random()*4)+1;
    corners=5;    
    xCorners=new int [corners];   
    yCorners=new int [corners]; 
    xCorners[0]=0*rockSize;
    yCorners[0]=10*rockSize;
    xCorners[1]=10*rockSize;
    yCorners[1]=8*rockSize;
    xCorners[2]=8*rockSize;
    yCorners[2]=-10*rockSize;
    xCorners[3]=-8*rockSize;
    yCorners[3]=-8*rockSize;
    xCorners[4]=-11*rockSize;
    yCorners[4]= 6*rockSize;
    myColor=color(180);   
    myCenterX=Math.random()*width;
    myCenterY=Math.random()*height;    
    myDirectionX=(Math.random()*4)-2;
    myDirectionY=(Math.random()*4)-2;
    myPointDirection=Math.random()*360;
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

    //check if colliding with bullet
    for(int i=0; i<bullets.size(); i++)
    {
      for (int w=0; w<rocks.size();w++)
      {
          if(dist((float)(bullets.get(i).myCenterX),(float)(bullets.get(i).myCenterY),(float)(rocks.get(w).myCenterX),(float)(rocks.get(w).myCenterY))<=20)
          {
            bullets.remove(i);
            rocks.remove(w);
            numberShot.add(1);
            break;
         }
      }
    }

    // //IF COLLIDING WITH SHIP
    // for (int h=0; h<rocks.size();h++)
    // {
    //   if(dist((float)(ship.myCenterX),(float)(ship.myCenterY),(float)(rocks.get(h).myCenterX),(float)(rocks.get(h).myCenterY))<=25)
    //   {
    //     gameOver=true;
    //     ship.setDirectionX(0);
    //     ship.setDirectionY(0);
    //     break;
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

