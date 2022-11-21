class SecondWindow extends PApplet { //<>// //<>// //<>// //<>// //<>//
  SecondWindow() {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
  }

  void settings() {
    fullScreen(P3D, 1);
  }

  void setup() { 
  }

  void draw() {
    sceneManager.secondDisplay(this.g);
  }
  
  void mousePressed() {
  sceneManager.mousePressed(this);
}

  void keyPressed() {
    sceneManager.keyPressed(keyCode);
  }
}
