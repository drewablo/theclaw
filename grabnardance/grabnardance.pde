
import ddf.minim.analysis.*;
import ddf.minim.*;
import processing.serial.*;

int pos=90; // set servo's value to center

Minim minim;  
AudioPlayer jingle;
FFT fftLin;
FFT fftLog;
Serial port; // 


void setup()
{
  size(512, 480);
  port = new Serial(this, "COM6", 19200);
  minim = new Minim(this);
  jingle = minim.loadFile("angels.mp3", 1024);
  
  // loop the file
  jingle.loop();
  
  // create an FFT object that has a time-domain buffer the same size as jingle's sample buffer
  // note that this needs to be a power of two 
  // and that it means the size of the spectrum will be 1024. 
  // see the online tutorial for more info.
  fftLin = new FFT( jingle.bufferSize(), jingle.sampleRate() );

  fftLin.linAverages( 1 );

  fftLog = new FFT( jingle.bufferSize(), jingle.sampleRate() );

  rectMode(CORNERS);

}

void draw()
{
  background(0);
  int num;
 
  float centerFrequency = 0;
  
  // perform a forward FFT on the samples in jingle's mix buffer
  // note that if jingle were a MONO file, this would be the same as using jingle.left or jingle.right
  fftLin.forward( jingle.mix );
  fftLog.forward( jingle.mix );
 
  {
    int w = int( width/fftLin.avgSize() );
    for(int i = 0; i < fftLin.avgSize(); i++)
    {
          fill(255);
      
      // draw a rectangle for each average, multiply the value by spectrumScale so we can see it better
      rect(i*w, height, i*w + w, height - fftLin.getAvg(i)*120);
      num = (int) (fftLin.getAvg(i)*100);
      num = Math.round(num);
      if ((num > 80) && (num <= 180))
      {
        port.write(num);
      }
      println(num);
      
    }
  }
  
 
}
