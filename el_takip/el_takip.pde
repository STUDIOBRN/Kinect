// Control Arabirim kütüphanesi yükeleme
import controlP5.*;
ControlP5 controlP5r;
ControlP5 controlP5;

import SimpleOpenNI.*;
//import processing.opengl.*;


SimpleOpenNI context;
float        zoomF =0.5f;
float        rotX = radians(180);  // by default rotate the hole scene 180deg around the x-axis, 
// the data from openni comes upside down
float        rotY = radians(0);
boolean      handsTrackFlag = false;
PVector      handVec = new PVector();
ArrayList    handVecList = new ArrayList();
int          handVecListSize = 30 ;
String       lastGesture = "";

void setup()
{
  
  size(800, 600, P3D); //Ekran boyutu, 3D - screen size and depth
  UI();   // Kullanıcı arayüzü  
  context = new SimpleOpenNI(this); // OpenNI kütüphanesini tanıt,
  colorMode(HSB, 255); // Renk havuzu HSB - Color Mode
  context.setMirror(true); //Ayna mirror
  
  // Derinlik haritalama oluşturmayı aktif et - eğer ektif olmassa hata mesajı çıkar 
  if (context.enableDepth() == false)
  {
    println("Derinlik haritalama oluşturulamıyor, kamerayı kontrol edin!"); 
    exit();
    return;
  }

  // elleri aktife e + jestleri yükle
  context.enableGesture();
  context.enableHands();

  // odak yakalamaları ekleyin    
  context.addGesture("Wave");
  context.addGesture("Click");
  context.addGesture("RaiseHand");

  context.setSmoothingHands(.1);  // eli yakalama fonksiyonunun ne kadar pürüzsüz olmalıdır onu ayarlayın
  //stroke(255, 255, 255);
  smooth();
  perspective(radians(45), 
  float(width)/float(height), 
  10.0f, 15000.0f);
}

void draw()
{
  // döndürme fonksiyonu yaratma
  // update the cam
  context.update();
  background(0, 0, 0);
  baran++;

  //-------------------------------------------------------------- 
  // set the scene pos
  translate(width/2, height/2, 0);
  rotateX(rotX);
  rotateY(rotY);
  scale(zoomF);

  //-------------------------------------------------------------
  // draw the 3d point depth map
  int[]   depthMap = context.depthMap();

  int     index;
  PVector realWorldPoint;

  translate(0, 0, -500);  // kameranın sahne rotasyonunu ayarla

  for (int y=0;y < context.depthHeight();y+=stepY)
  {
    for (int x=0;x < context.depthWidth();x+=stepX)
    {
      index = x + y * context.depthWidth();      
      if (depthMap[index] > 0)
      { 
        //-----------------------------------------------------------   
        // Yansıtılan nokları çiz
        realWorldPoint = context.depthMapRealWorld()[index];
        strokeWeight(ADotSize); // Nokta kalınlıkları
        stroke(ADotRenk, ADotSat, ADotPar, ADotOpa); // Nokta Renkleri
        point(realWorldPoint.x, realWorldPoint.y, realWorldPoint.z); // Nokta Koordinatları
      }
    }
  } 
  
  // draw the tracked hand
  if (handsTrackFlag) // kütüphaneden el takip clasını yükledikten sonra durum oluştur  
  {
    pushStyle(); // yeni stlide çizime başla
    fill(formRenk, formSat, formPar, formOpa); // çizgileri doldurma
    Iterator itr = handVecList.iterator();  // Bir veri grubunun elemanlarına sırayla erişim sağlayan yapı 
    
    beginShape(); // şekle başlama fonksiyonu
    while ( itr.hasNext () )  // bir sonraki sıramalama kadar 
     { 
        PVector p = (PVector) itr.next(); // vectorun hızı     
        strokeWeight(LWid); // çizim kalınlığı 
        stroke(LRenk, LSat, LPar, LOpa);  // çizim rengi
        vertex(p.x, p.y, p.z);   // takip çizgilerinin koordinatları
     } 
    endShape(); // şekli bitir
    stroke(pointRenk, pointSat, pointPar, pointOpa); // sahne üzerindeki nokta renkleri
    strokeWeight(pointSize); // Sahne üzerindeki noktalama boyutu 
    point(handVec.x, handVec.y, handVec.z); 
    
    //takip çizgilisi aktif / pasif butonu 
    if (takip == true ) { 
     itr.remove();
    }
  
  popStyle(); 
  }
   
   
  // X Ekseninde döndürme Fonksiyonu  
  if (donX == true ){
  rotX+=frameRate/XHiz;
  }
  // Y ekseninde döndürme fonksiyonu 
  if (donY == true ){
  rotY+=frameRate/YHiz;
  }
  
  //  context.drawCamFrustum();  // Kinect kamerası sanal görünümü
}

// -----------------------------------------------------------------

// hand events

void onCreateHands(int handId, PVector pos, float time)
{
 // println("onCreateHands - handId: " + handId + ", pos: " + pos + ", time:" + time);

  handsTrackFlag = true;
  handVec = pos;
  handVecList.clear();
  handVecList.add(pos);
}

void onUpdateHands(int handId, PVector pos, float time)
{
  //println("onUpdateHandsCb - handId: " + handId + ", pos: " + pos + ", time:" + time);
  handVec = pos;

  handVecList.add(0, pos);
  if (handVecList.size() >= handVecListSize)


  { // remove the last point 
    handVecList.remove(handVecList.size()-1);
  }
}

void onDestroyHands(int handId, float time)
{
  //println("onDestroyHandsCb - handId: " + handId + ", time:" + time);

  handsTrackFlag = false;
  context.addGesture(lastGesture);
}

// -----------------------------------------------------------------
//  Hareket olayları
void onRecognizeGesture(String strGesture, PVector idPosition, PVector endPosition)
{
  // println("onRecognizeGesture - strGesture: " + strGesture + ", idPosition: " + idPosition + ", endPosition:" + endPosition);
  lastGesture = strGesture;
  context.removeGesture(strGesture); 
  context.startTrackingHands(endPosition);
}

void onProgressGesture(String strGesture, PVector position, float progress)
{
  //println("onProgressGesture - strGesture: " + strGesture + ", position: " + position + ", progress:" + progress);
}
// -----------------------------------------------------------------
//Çerçeve kaldırma fonksiyonu
//public void init() {
//frame.removeNotify();
//frame.setUndecorated(true);
//frame.addNotify();
// super.init();
//}

