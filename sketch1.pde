int currentNum = 0;
int maxIndex = 8;
float currentSz = 10;
float maxSize = 40;
float[] currentPos={0,0};
float[] currentColor ={0,0,0};
void setup()
{
  size(displayWidth,displayHeight);
  background(0);
  currentPos[0]=width/2.f;
  currentPos[1]=height/2.f;
//  currentColor = getColorForIndex(currentNum);
}

void draw()
{
//  background(0);
colorMode(RGB,256);
  fill(0,0,0,5);
  rect(0,0,width,height);
  
  updateNum();
  updatePos();
  renderPos();
}

void renderPos()
{

  int newc = getColorForIndex(currentNum);
  colorMode(RGB, 256);
  float newR = red(newc);
  float newG = green(newc);
  float newB = blue(newc);
//  println(newR + " " + newG + " " + newB);
  currentColor[0] = lerp(currentColor[0],newR, .1);
  currentColor[1] = lerp(currentColor[1],newG, .1);
  currentColor[2] = lerp(currentColor[2],newB, .1);
  int newColor = color(currentColor[0],currentColor[1],currentColor[2],256);
  fill(newColor);
  noStroke();
  ellipse(currentPos[0],currentPos[1],currentSz,currentSz);
}

void updatePos()
{
  float[] tmp = getPositionForIndex(currentNum);
  float d = dist(currentPos[0],currentPos[1],tmp[0],tmp[1]);
  float maxDist = sqrt(width*width+height*height);
  d/=maxDist; //normalize
  d = 1-d;
  float newSz = d*maxSize;
  currentSz =  lerp(currentSz,newSz,.5);
  currentPos[0] = lerp(currentPos[0],tmp[0],.05);
  currentPos[1] = lerp(currentPos[1],tmp[1],.05);
}


int getColorForIndex(int index)
{
  colorMode(HSB, 256);
  return color(index*256/maxIndex,256,256);
}

float[] getPositionForIndex(int index)
{
  float rad = (index*1.f/8)*TWO_PI;
//  return new float[]{(width/2.f) * (1+cos(rad)), 
//                     (height/2.f) * (1+sin(rad)) };
   return new float[]{(width/2.f) + (width/2.f-maxSize/2) *cos(rad), 
                      (height/2.f) + (height/2.f-maxSize/2) *sin(rad) };
}

long updateFrequency = 500;
long nextUpdate = millis()+updateFrequency;
void updateNum()
{
  if(millis() > nextUpdate)
  {
    currentNum = (int)(random(maxIndex));
    println("currentNum: " + currentNum);
    nextUpdate += updateFrequency;
  }
}


