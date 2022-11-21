class ExperimentScene {
  DummyCursor dummycursor;
  int experimentCount; 
  int experimentCountMax;
  IntList cursornumList = new IntList();
  int firstMillis;
  float elapsedSeconds;

  ExperimentScene() {
    for (int i = 0; i < settionNum; i++)
      cursornumList.append(cursornums);
    cursornumList.shuffle();

    experimentCount = 0;
    experimentCountMax = cursornumList.size() ;
    dummycursor = new DummyCursor();
  }

  void init() {
    dummycursor.init(cursornumList.get(experimentCount));
    dummycursor.setPositions(0, fieldWidth, 0, fieldHeight, -fieldDepth, 0);
    firstMillis = millis();

    elapsedSeconds = firstMillis/1000;
  }

  void display() {
    dummycursor.display();
    if (isTimeOver() && dummycursor.isPlaying()) {
      dummycursor.stop();
      dummycursor.showCursorIds();
      dummycursor.saveData();
    }

    elapsedSeconds = (millis()-firstMillis)/1000;
  }

  int getCursorNum() {
    return cursornumList.get(experimentCount);
  }

  int getCorrectNum() {
    return dummycursor.getRealCursorNum();
  }

  float getTime() {
    return dummycursor.getTime() ;
  }

  boolean isCursorPlaying() {
    return  dummycursor.isPlaying();
  }

  boolean isTimeOver() {
    if (!dummycursor.isPlaying())return false;
    return millis() - firstMillis >= timeLimit;
  }


  void keyPressed(int _keyCode) {
    switch(_keyCode) {
    case ' ':
      dummycursor.stop();
      dummycursor.showCursorIds();
      dummycursor.saveData();
      break;
    case RIGHT:
      if (dummycursor.isPlaying())break;
      if (selectCursorNumberScene.selectNumber < 0)break;
      sceneManager.changeScene("CountDown");
      selectCursorNumberScene.addRow();
      experimentCount++;
      if (experimentCount < experimentCountMax)break;
      selectCursorNumberScene.save();
      sceneManager.changeScene("Finish");
      break;
    }
  }
}
