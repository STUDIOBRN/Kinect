// UI SET and LocationWindows 
void UI(){ 
 controlP5r = new ControlP5(this);
 controlP5 = new ControlP5(this);
 
 //SET WINDOWS SIZE 
 ControlWindow wl = controlP5r.addControlWindow("win",  230, 550);
 wl.setLocation(15, 15);  // SET LINE WINDOW LOCATION CONTROL WINDOW 
 
  ControlWindow w2 = controlP5.addControlWindow("win2",  230, 300);
  w2.setLocation(700, 15);  // SET LINE WINDOW LOCATION CONTROL WINDOW 
 
 //Change color gui
 controlP5r.setColorForeground(#89B41C);
 controlP5r.setColorActive(#769D0C);
 controlP5r.setColorBackground(#FFDB0A);
 controlP5r.setColorLabel(#356B13);
 
 controlP5.setColorForeground(#F70000);
 controlP5.setColorActive(#FE03FF);
 controlP5.setColorBackground(#FFDB0A);
 controlP5.setColorLabel(#356B13);
 
 
 ControlGroup wone = controlP5r.addGroup("LINE SETTINGS", 10, 20);
 wone.moveTo(wl); // MOVE TO CONTROL TO SECOND SCREEN
 controlP5r.begin(wl, 10, 30); // POSITION GROUP OF CONTROLS //lines color
 controlP5r.addSlider("stepX", 0, 15).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("stepY", 0, 15).linebreak();   // ADD SLIDER FOR RED VALUE
 
 controlP5r.addSlider("ADotSize", 0, 5).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("ADotRenk", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("ADotSat", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("ADotPar", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("ADotOpa", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE

 controlP5r.addSlider("LRenk", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("LSat", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("LPAr", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("LOpa", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("LWid", 0, 100).linebreak(); // ADD SLIDER FOR GREEN VALUE
 
 controlP5r.addSlider("formRenk", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("formSat", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("formPar", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("formOpa", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 
 controlP5r.addSlider("point", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("pointSat", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("pointPar", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5r.addSlider("pointOpa", 0, 255).linebreak();   // ADD SLIDER FOR RED VALUE
 
 controlP5r.addSlider("pointSize", 0, 100).linebreak(); // ADD SLIDER FOR GREEN VALUE
 

 controlP5r.addSlider("XHiz", 0, 1000).linebreak();  // ADD SLIDER FOR BLUE VALUE
 controlP5r.addSlider("YHiz", 0, 1000).linebreak(); // ADD SLIDER
 controlP5r.addSlider("par3",  0,   5).linebreak(); // ADD SLIDER // ADD SLIDER FOR BLUE VALUE
 controlP5r.addSlider("handVecListSize", 0, 500).linebreak(); 
 
  controlP5r.addToggle("takip"); // ADD NEW TOGGLE
  
  controlP5r.addToggle("donX"); // ADD NEW TOGGLE
  controlP5r.addToggle("donY"); // ADD NEW TOGGLE
  
  
 controlP5r.end();


 ControlGroup wtwo = controlP5.addGroup("SETTINGS", 10, 20);
 wtwo.moveTo(w2); // MOVE TO CONTROL TO SECOND SCREEN
 controlP5.begin(w2, 10, 30); // POSITION GROUP OF CONTROLS //lines color
 controlP5.addSlider("speedUP", 0, 15).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5.addSlider("", 0, 15).linebreak();   // ADD SLIDER FOR RED VALUE
 controlP5.addToggle("turn"); // ADD NEW TOGGLE
 controlP5.end();


}

// overrides the init() method so we can undecorate the
// main window first, then we have to call init() for the super class
// to init the sketch

