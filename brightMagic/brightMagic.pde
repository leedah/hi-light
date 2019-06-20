
import processing.video.*;
Capture video;

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

float bx;
float by;

void setup() {

    // start video
    size(640, 480); 
    video = new Capture(this, width, height, 30);
    video.start();
  
    // start communication with Wekinator
    oscP5 = new OscP5(this,9000);
    dest = new NetAddress("127.0.0.1",6448);
  
}

void draw() {
    
    if (video.available()) {    
        video.read();
        image(video, 0, 0, width, height); 
        bx = 0;
        by = 0; 
        float brightestValue = 0;
        video.loadPixels();
        int index = 0;
        for (int y = 0; y < video.height; y++) {
          for (int x = 0; x < video.width; x++) {
            color pixelValue = video.pixels[index];
            float pixelBrightness = brightness(pixelValue);
            if (pixelBrightness > brightestValue) {
              brightestValue = pixelBrightness;
              by = y;
              bx = x;
            }
            index++;
          }
        }
        drawInterface();
    }
    sendOsc();
}

void sendOsc() {
  
    OscMessage msg = new OscMessage("/wek/inputs");
    msg.add(bx); 
    msg.add(by);
    oscP5.send(msg, dest);
}

void drawInterface() {
  
    textSize(20); 
    stroke(255, 255, 255);    
    
    // reverb
    fill(235,0, 235, 50);
    rect(0 , 0,width/2, height);
    line(0, height/2, width*0.75, height/2);
    line( width/2, 0, width/2, height);
    fill(255, 255, 255);
    text("REVERB", width/4 -40 , height/4);
    textSize(17);
    text("wet", 10 , height/2 -10);     
    text("dry", width/2 -40 ,20);
    
    // vcf
    line( width *0.75, height/2, width *0.75, height);
    fill(60, 211, 211, 100);
    rect(width/2, height/2, width/4, height/2);
    fill(255, 255, 255);
    textSize(20); 
    text("VCF", width/2 + 65 , height*0.75);
    textSize(17);
    text("f", width *0.75 -30 ,height/2 + 20); 
    
    // center 
    ellipse(width/2, height/2, 10, 10);
   
    // brightest point
    stroke(0, 0, 0);
    fill(255, 224, 0, 128);
    ellipse(bx, by,50, 50);
     
    // top right - pop (normal speed)
    textSize(19); 
    fill(235,94, 122, 128);
    rect(width -102 , 0, 100, 100);
    fill(255, 255, 255);
    text("play",width -70 , 50); 
 
    // bottom right - new wave
    fill(0, 100, 211, 128);
    strokeWeight(2);
    rect(width -102 ,height-102, 100, 100);
    fill(255,255, 255);
    text("new wave", width -95 ,height-50); 

}
