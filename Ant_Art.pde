// Ant Painting
// Sunil Kumar Yadav
// Created using Processing 
// Reference:Book - The Art of Artificial Evolution - A Handbook on Evolutionary Art and Music, Chapter 11 "Artificial Art made by Artificial Ants." Page 227-248,  
// Authors: N.Monmarche', I. Mahnich, M.Slimane.
 
int dim = 400; // size of the applet window
int ant_num = int(random(4.5, 15.5)); // number of ants chosen between a range 5 to 15
boolean halt = false; // to pause by pressing any key
long  count = 0; // iteration counter
//import processing.video.*;
//MovieMaker sky;

float[] tempx = new float[ant_num]; // To get the orientation  
float[] tempy = new float[ant_num];
float[] tempxx = new float[ant_num];   
float[] tempyy = new float[ant_num];

Ant[] ant = new Ant[ant_num]; // Universe of Ants // as an array of objects of Ant Class // Declared globally to be called by method draw.

//MAIN

void setup() 
{
  size(400,400,P3D);
  smooth();
  color back_color = color (0,0,0); // (Custom)
  background (back_color);  // setting background color  
  //sky = new MovieMaker(this, width, height, "antart.mov",300, MovieMaker.H263, MovieMaker.HIGH);
  
  for (int i=0; i<ant_num; i++) // initialisation of ants
    {
      ant[i] = new Ant(0,0);
      ant[i].x = int(random(0,dim));
      ant[i].y = int(random(0,dim));
      tempx[i] = ant[i].x;
      tempy[i] = ant[i].y; 
      tempxx[i] = ant[i].x;
      tempyy[i] = ant[i].y;
      ant[i].col_laid = color (int(random(0,255)),int(random(0,255)),int(random(0,255)));  // colors in paintings can be controlled varying the RGB ranges.(Custom)
      ant[i].Do = random(0,1);
      ant[i].Dr = 1 - ant[i].Do; //either ant is oblique moving or right angled moving // helps in deciding ant dynamics in absence of pheromones
    }  
  
  for (int i=0; i<ant_num; i++)
    {  // selection of color to be followed
      if (i < ant_num - 1)
      {
      ant[i].col_look = ant[i+1].col_laid;
      }
      else
      ant[ant_num-1].col_look = ant[0].col_laid;
    }
    
 }
  
// DRAW 

void draw()
{  
  frameRate(60); // argument controls frame rate (subjected to hardware limitations)
  for(int i=0;i<ant_num;i++)
  {
          stroke(ant[i].col_laid);
          strokeWeight(2); // (Custom) Stroke Weights can be altered to give different art forms
          point(ant[i].x,ant[i].y); // (Custom) e.g. ellipse(x,y,width,height) instead of point deposition


          if (ant[i].x > dim || ant[i].y > dim || ant[i].x < 0 || ant[i].y < 0)   // in case ant goes outside the window enters randomly at screen
          {
            ant[i].x = int(random(0,dim));
            ant[i].y = int(random(0,dim));
           }
             
          // Luminance Comparison [Ref: B1]
                  float[] tempred = new float[8];
                  float[] tempgreen = new float[8];
                  float[] tempblue = new float[8];
                  float[] luminance = new float [8];
                  float[] delta_lum = new float [8];
                  int lum_crit = 40; // (Custom) can be varied to control pheromone following
                       
                  tempred[0] = red(color(get(ant[i].x+1,ant[i].y+1)));
                  tempred[1] = red(color(get(ant[i].x+1,ant[i].y  )));
                  tempred[2] = red(color(get(ant[i].x+1,ant[i].y-1)));
                  tempred[3] = red(color(get(ant[i].x,ant[i].y+1  )));
                  tempred[4] = red(color(get(ant[i].x,ant[i].y-1  )));
                  tempred[5] = red(color(get(ant[i].x-1,ant[i].y+1)));
                  tempred[6] = red(color(get(ant[i].x-1,ant[i].y  )));
                  tempred[7] = red(color(get(ant[i].x-1,ant[i].y-1)));
                  
                  tempgreen[0] = green(color(get(ant[i].x+1,ant[i].y+1)));
                  tempgreen[1] = green(color(get(ant[i].x+1,ant[i].y  )));
                  tempgreen[2] = green(color(get(ant[i].x+1,ant[i].y-1)));
                  tempgreen[3] = green(color(get(ant[i].x,ant[i].y+1  )));
                  tempgreen[4] = green(color(get(ant[i].x,ant[i].y-1  )));
                  tempgreen[5] = green(color(get(ant[i].x-1,ant[i].y+1)));
                  tempgreen[6] = green(color(get(ant[i].x-1,ant[i].y  )));
                  tempgreen[7] = green(color(get(ant[i].x-1,ant[i].y-1)));
                  
                  tempblue[0] = blue(color(get(ant[i].x+1,ant[i].y+1)));
                  tempblue[1] = blue(color(get(ant[i].x+1,ant[i].y  )));
                  tempblue[2] = blue(color(get(ant[i].x+1,ant[i].y-1)));
                  tempblue[3] = blue(color(get(ant[i].x,ant[i].y+1  )));
                  tempblue[4] = blue(color(get(ant[i].x,ant[i].y-1  )));
                  tempblue[5] = blue(color(get(ant[i].x-1,ant[i].y+1)));
                  tempblue[6] = blue(color(get(ant[i].x-1,ant[i].y  )));
                  tempblue[7] = blue(color(get(ant[i].x-1,ant[i].y-1)));
           
                  
                  for (int c = 0;c < 8; c++)
                  {
                    luminance[c] = 0.2426*tempred[c] + 0.7152*tempgreen[c] + 0.0722*tempblue[c];
                    delta_lum[c] = abs(luminance[c] - (0.2426*red(ant[i].col_look) + 0.7152*green(ant[i].col_look) + 0.0722*blue(ant[i].col_look) ));
                  }
                   
                                  if (delta_lum[0] < lum_crit ) 
                                                {
                                                  ant[i].x = ant[i].x + 1;     
                                                  ant[i].y = ant[i].y + 1 ; 
                                                }
                                  else if (delta_lum[1] < lum_crit)
                                                {
                                                  ant[i].x = ant[i].x + 1;      
                                                  ant[i].y = ant[i].y ; 
                                                }
                                  else if (delta_lum[2] < lum_crit)
                                                {
                                                  ant[i].x = ant[i].x + 1;      
                                                  ant[i].y = ant[i].y - 1;
                                                }
                                  else if (delta_lum[3] < lum_crit)
                                                {
                                                  ant[i].x = ant[i].x ;      
                                                  ant[i].y = ant[i].y + 1;
                                                }
                                  else if (delta_lum[4] < lum_crit )
                                                {
                                                  ant[i].x = ant[i].x ;      
                                                  ant[i].y = ant[i].y - 1;
                                                }
                                  else if (delta_lum[5] < lum_crit  )
                                                {
                                                  ant[i].x = ant[i].x - 1;     
                                                  ant[i].y = ant[i].y + 1 ;
                                                }
                                  else if (delta_lum[6] < lum_crit)
                                                {
                                                  ant[i].x = ant[i].x - 1;      
                                                  ant[i].y = ant[i].y  ;
                                                }
                                  else if (delta_lum[7] < lum_crit)
                                                {
                                                  ant[i].x = ant[i].x - 1;      
                                                  ant[i].y = ant[i].y - 1;
                                                }
   
          else // Ant Dynamics in absence of pheromone in neighbourhood based upon type of ant
                            {
                              if(ant[i].Do >= 0.5)
                              {
                                                        if((tempx[i] - tempxx[i] == 0) && (tempy[i] - tempyy[i] == 0) )    // to initiate the movements in first instance                          
                                                                    {
                                                                      ant[i].x = ant[i].x + int(random(-2,2));      
                                                                      ant[i].y = ant[i].y + int(random(-2,2));
                                                                    } 
                                                        else if((tempx[i] - tempxx[i] < 0) && (tempy[i] - tempyy[i] < 0) )  // entered from South East                            
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 10 && move < 15)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 15 && move < 20)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 30)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y;}   
                                                                     }
                                                        else if((tempx[i] - tempxx[i] < 0) && (tempy[i] - tempyy[i] == 0) )   // entered from East                          
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 10 && move < 15)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 15 && move < 20)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x - 1 ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 30)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y + 1 ;}
                                                                    } 
                                                        else if((tempx[i] - tempxx[i] < 0) && (tempy[i] - tempyy[i] > 0) )   // entered from North East                          
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 10 && move < 15)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 15 && move < 20)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x - 1 ;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 30)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y + 1 ;}
                                                                    } 
                                                        else if((tempx[i] - tempxx[i] == 0) && (tempy[i] - tempyy[i] < 0) )  // entered from South                             
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 10 && move < 15)
                                                                          {ant[i].x = ant[i].x + 1 ;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 15 && move < 20)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x + 1 ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 30)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y - 1 ;}
                                                                    }
                                                        else if((tempx[i] - tempxx[i] == 0) && (tempy[i] - tempyy[i] > 0) )   // entered from North                          
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 10 && move < 15)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 15 && move < 20)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x - 1 ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 30)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y + 1 ;}
                                                                    } 
                                                        else if((tempx[i] - tempxx[i] > 0) && (tempy[i] - tempyy[i] < 0) )   // entered from South West                          
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 10 && move < 15)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 15 && move < 20)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x + 1 ;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 30)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y - 1 ;}
                                                                    }
                                                        else if((tempx[i] - tempxx[i] > 0) && (tempy[i] - tempyy[i] == 0) )   // entered from West                         
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 10 && move < 15)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 15 && move < 20)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x + 1 ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 30)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y - 1 ;}
                                                                    } 
                                                        else if((tempx[i] - tempxx[i] > 0) && (tempy[i] - tempyy[i] > 0) )   // entered from North West                          
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 10 && move < 15)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 15 && move < 20)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x  ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 30)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y  ;}
                                                                    }  
                              }
                       else   
                              {
                                                         if((tempx[i] - tempxx[i] == 0) && (tempy[i] - tempyy[i] == 0) )    // to initiate the movements in first instance                          
                                                                    {
                                                                      ant[i].x = ant[i].x + int(random(-2,2));      
                                                                      ant[i].y = ant[i].y + int(random(-2,2));
                                                                    } 
                                                          else if((tempx[i] - tempxx[i] < 0) && (tempy[i] - tempyy[i] < 0) )  // entered from South East                            
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 10 && move < 20)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 30 && move < 35)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 35)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y;}   
                                                                     }
                                                        else if((tempx[i] - tempxx[i] < 0) && (tempy[i] - tempyy[i] == 0) )   // entered from East                          
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 10 && move < 20)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 30 && move < 35)
                                                                          {ant[i].x = ant[i].x - 1 ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 35)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y + 1 ;}
                                                                    } 
                                                        else if((tempx[i] - tempxx[i] < 0) && (tempy[i] - tempyy[i] > 0) )   // entered from North East                          
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 10 && move < 20)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 30 && move < 35)
                                                                          {ant[i].x = ant[i].x - 1 ;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 35)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y + 1 ;}
                                                                    } 
                                                        else if((tempx[i] - tempxx[i] == 0) && (tempy[i] - tempyy[i] < 0) )  // entered from South                             
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 10 && move < 20)
                                                                          {ant[i].x = ant[i].x + 1 ;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 30 && move < 35)
                                                                          {ant[i].x = ant[i].x + 1 ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 35)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y - 1 ;}
                                                                    }
                                                        else if((tempx[i] - tempxx[i] == 0) && (tempy[i] - tempyy[i] > 0) )   // entered from North                          
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 10 && move < 20)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 30 && move < 35)
                                                                          {ant[i].x = ant[i].x - 1 ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 35)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y + 1 ;}
                                                                    } 
                                                        else if((tempx[i] - tempxx[i] > 0) && (tempy[i] - tempyy[i] < 0) )   // entered from South West                          
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 10 && move < 20)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 30 && move < 35)
                                                                          {ant[i].x = ant[i].x + 1 ;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 35)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y - 1 ;}
                                                                    }
                                                        else if((tempx[i] - tempxx[i] > 0) && (tempy[i] - tempyy[i] == 0) )   // entered from West                         
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y ;}
                                                                      else if( move >= 10 && move < 20)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x ;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 30 && move < 35)
                                                                          {ant[i].x = ant[i].x + 1 ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 35)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y - 1 ;}
                                                                    } 
                                                        else if((tempx[i] - tempxx[i] > 0) && (tempy[i] - tempyy[i] > 0) )   // entered from North West                          
                                                                    {
                                                                      float move = random(40);
                                                                      if(move < 10)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 10 && move < 20)
                                                                          {ant[i].x = ant[i].x - 1;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 20 && move < 30)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y - 1;}
                                                                      else if( move >= 30 && move < 35)
                                                                          {ant[i].x = ant[i].x  ;      
                                                                           ant[i].y = ant[i].y + 1;}
                                                                      else if( move >= 35)
                                                                          {ant[i].x = ant[i].x + 1;      
                                                                           ant[i].y = ant[i].y  ;}
                                                                    } 
                      
                      
                              }        
                                    
                            }   
             
             
          tempxx[i] = tempx[i]; // Update for Orientation Arrays
          tempyy[i] = tempy[i];   
          tempx[i] = ant[i].x;
          tempy[i] = ant[i].y;
                     
                          
  }
 // sky.addFrame(); 
  count +=  1;
  println(count);
 }
 
// Press any key to stop the simulation
void keyPressed()
 {
  halt = !halt;
  if (halt)
    {
    noLoop();
//    sky.finish();
    }
    
  else
    loop();
 }   
 
//CLASS ANT
class Ant {
  int x,y; // initial position 
  color col_laid;   // color laid down
  color col_look;   // color looking for
  float Do, Dr; //type of ant, Do for oblique ants, Dr for right angled ants
  Ant(int X, int Y) // constructor
  {                     
    x = X;
    y = Y;
  }
}
  