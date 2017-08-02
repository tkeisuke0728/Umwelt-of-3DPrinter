import oscP5.*;//OSC受信用のライブラリをインポート
import processing.serial.*; 


Serial myPort;
String lin;
int ln;
String lines[];
int i = 0;
int receive;
boolean state =false;
boolean ok = false;
String [] strX;
String [] strY;
float GX;
float GY;
int[] preValue = new int[6];

OscP5 oscP5;    //受信用の変数
int A,B,C,D,E,F ;    
boolean sw =false;
void setup() { 
  size(800, 800);
  background(255);
  frameRate(30);
  lines = loadStrings("bunny.gcode");
  println( Serial.list() ); // This gets the first port on your computer. 
  myPort = new Serial(this, "/dev/tty.usbserial-A703B3JX", 250000); 

  oscP5 =  new OscP5(this, 8000);
oscP5.plug(this,"getData","/position");

  ln =0;
}

//相手側からのメッセージを受け取るコード。fromAとfromBをそれぞれx, yに代入
public void getData(int fromA, int fromB, int fromC, int fromD,int fromE, int fromF) {
  A = fromA; 
  B = fromB;
  C = fromC; 
  D = fromD;
  E = fromE; 
  F = fromF;
}

void draw() {

  
 println(A+ " " +B +" "+ C+ " " +D+" "+ E+ " " +F);

  String ttt = myPort.readString();
  if (ttt != null) {

    println(ttt);
    if (ttt.charAt(0) == 'o') {
      ok =true;
      println("ok is true");
    } else {
      ok =false;
    }
    
     getData(A,B,C,D,E,F) ;
     
     if(sw == true){
    attack(A,B,C,D,E,F);
   
     }
    gcodedraw();
  }



  if ( state==true) {
    printing();
  }
}

public void printing() {
  lin =lines[i];

  if ( lin.charAt(0) ==';') {
    println(i + lin);
    myPort.write(lin + '\n');
    i ++;
  } else if (ok) {
    myPort.write(lin + '\n');
    println(i + " : " +lin);
    i ++;

    ok = false;
  }
}

public void gcodedraw() {
  
 if (lin != null && lin.length()>12&& lin.charAt(3)=='X'&&lin.charAt(12)=='Y' ) {

  
      strX = split( split(lin, " ")[1], "X");
      GX = float(strX[1]);

      strY = split( split(lin, " ")[2], "Y");
      GY = float(strY[1]);
 GX = (map(GX,0,200,0,800));
 GY = (map(GY,0,200,800,0));
  println("("+ GX +"," +GY+ ")");

  fill(235,50);
 
  rect(0,0,width,height);
  
  fill(0);
   ellipse(GX, GY, 5, 5);
   
  }
  
 

}
void keyPressed() {

  if (key == 'h') {
    myPort.write("G28\n"); 
    println("here");
  }

  if (key == 'x') {
    myPort.write("G1 X100 Y0 Z0 F4000\n"); 
    println("G1 X100 Y0 Z0 F4000\n");
  }

  if (key == 'y') {
    myPort.write("G1 X0 Y100 Z0 F4000\n");
    print("G1 X0 Y100 Z0 F4000");
  } 

  if (key == 's') {
    state =true;
  } 

  if (key == 'a') {
    receive =1;
  } 


  if (key == 'z') {
    myPort.write("G1 X0 Y0 Z200 F1000\n");
    println("G1 X0 Y0 Z200 F1000");
  } 

  if (key == 'c') {
    myPort.write("G1 X0 Y0 Z0 F4000\n");
    println("G1 X0 Y0 Z0 F4000");
  }
  
  if (key == 'd') {
  sw =true;
  }
  if (key == 'f') {
  sw =false;
  }
}

void mousePressed() {

  point(mouseX, mouseY, 5);
  color(0);
  String text = "G1 X";
  text += str(map(mouseX, 0, 800, 0, 200));
  text += " Y";
  text += str(map(mouseY, 0, 800, 200, 0));
  text +=(" F4000\n");
  println(text);
  myPort.write(text);
}



void attack(int a,int b, int c, int d,int e,int f) {
  if(preValue[0] == 0 & a ==1 ){
    
    myPort.write("G1 X30 Y30 Z60\n");
    myPort.write("G91\n");
    myPort.write("G1 Z60  E30\n");
    myPort.write("G1 Z-120\n");
   myPort.write("G90\n");
  }
  preValue[0] = a;
  
   if(preValue[1] == 0 &b ==1){
     myPort.write("G1 X50 Y30 Z60\n");
    myPort.write("G91\n");
    myPort.write("G1 Z60  E30\n");
    myPort.write("G1 Z-120\n");
   myPort.write("G90\n");
  }
   preValue[1] = b;
  
    if(preValue[2] == 0 &c ==1){

    myPort.write("G1 X80 Y30 Z60\n");
    myPort.write("G91\n");
    myPort.write("G1 Z60  E30\n");
    myPort.write("G1 Z-120\n");
   myPort.write("G90\n");
  }
  preValue[2] = c;
    if(preValue[3] == 0 &d ==1){
   myPort.write("G1 X110 Y30 Z60\n");
    myPort.write("G91\n");
    myPort.write("G1 Z120  E60\n");
    myPort.write("G1 Z-120\n");
    myPort.write("G90\n");
  }
  preValue[3] = d;
    if(preValue[4] == 0 &e ==1){
   
   myPort.write("G1 X140 Y30 Z60\n");
    myPort.write("G91\n");
    myPort.write("G1 Z120  E60\n");
    myPort.write("G1 Z-120\n");
    myPort.write("G90\n");
  }
  preValue[4] = e;
  
    if(preValue[5] == 0 &f ==1){
 
   myPort.write("G1 X170 Y30 Z60\n");
    myPort.write("G91\n");
    myPort.write("G1 Z120  E60\n");
    myPort.write("G1 Z-120\n");
    myPort.write("G90\n");
  }
  
  preValue[5] = f;
}