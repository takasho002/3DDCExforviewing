class PractiseScene {
  DummyCursor dummycursor;
  int practiseCount; 
  int practiseCountMax;
  int firstMillis;

  PractiseScene() {
    practiseCount = 0;
    practiseCountMax =practiseCursornums.size();
    dummycursor = new DummyCursor();
  }

  void init() {
    dummycursor.init(practiseCursornums.get(practiseCount));
    dummycursor.setPositions(0, fieldWidth, 0, fieldHeight, -fieldDepth, 0);
    firstMillis = millis();
  }

  void display() {
    dummycursor.display();

    if (isTimeOver() && dummycursor.isPlaying()) {
      dummycursor.stop();
      dummycursor.showCursorIds();
      dummycursor.showAnswer();
    }
  }


  void keyPressed(int _keyCode) {
    switch(_keyCode) {
    case ' ':
      dummycursor.stop();
      dummycursor.showCursorIds();
      break;
    case 83:
      if (!dummycursor.isPlaying())
        dummycursor.showAnswer();
      break;
    case RIGHT:
      if (!dummycursor.isShowingAnswer())break;
      practiseCount++;
      if (practiseCount >= practiseCountMax) {
        isPractise = false;
        sceneManager.changeScene("BreakTime");
      } else {
        sceneManager.changeScene("CountDown");
      }
      break;
    }
  }

  boolean isTimeOver() {
    if (!dummycursor.isPlaying())return false;
    return millis() - firstMillis >= timeLimit;
  }
}
