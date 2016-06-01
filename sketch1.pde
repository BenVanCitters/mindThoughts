int currentNum = 0;
int maxIndex = 8;
float currentSz = 10;
float maxSize = 40;
float[] currentPos={0,0};

void setup()
{
  size(500,500);
  background(0);
  currentPos[0]=width/2.f;
  currentPos[1]=height/2.f;
}

void draw()
{
//  background(0);
  println("currentNum: " + currentNum);
  updateNum();
  updatePos();
  renderPos();
}

void renderPos()
{
  int c = getColorForIndex(currentNum);
  fill(c);
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
  return new float[]{(width/2.f) * (1+cos(rad)), 
                     (height/2.f) * (1+sin(rad)) };
}

long updateFrequency = 1000;
long nextUpdate = millis()+updateFrequency;
void updateNum()
{
  if(millis() > nextUpdate)
  {
    currentNum = (int)(random(maxIndex));
    nextUpdate += updateFrequency;
  }
}


