# The hi-light system
Play music and control audio effects by moving a light source . Webcam detects the brightest point and sends it to Wekinator via OSC. Wekinator trains 4 models on continous outputs which are passed to Pure Data. 

Using the Pure Data  patch we can load a wav file and have different playback options. Pure data maps the 4 continous values of Wekinator to control Reverb (dry, wet parameters), the VCF (central frequency) and to switch between velocities.

You can see a demo here: https://www.youtube.com/watch?v=-DjxiXY9RnE
