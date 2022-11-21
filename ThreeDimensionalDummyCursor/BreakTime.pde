class BreakTime {

  void display() {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(100);
    text("Next: THE ACTUAL PLAY\n ARE YOU READY?", displayWidth/2, displayHeight/2);
    textSize(50);
    text("PLEASE PRESS SPASE KEY", displayWidth/2, 3*displayHeight/4);
  }

  void keyPressed(int _keyCode) {

    if (_keyCode == ' ')sceneManager.changeScene("CountDown");
  }
}
