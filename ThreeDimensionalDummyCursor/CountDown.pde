class CountDown {
  int firstMillis;

  CountDown() {
    firstMillis = millis();
  }

  void display() {
    background(0);
    int millis = millis() - firstMillis;
    int second = 3 - round(millis/1000);


    fill(255);
    textAlign(CENTER, CENTER);
    textSize(100);
    text(second, displayWidth/2, displayHeight/2);

    String status;
    int sessionCount, allSessionNumber;
    if (isPractise) {
      status = "Practise";
      sessionCount = practiseScene.practiseCount + 1;
      allSessionNumber =   practiseScene.practiseCountMax;
    } else {
      status = "Experiment";
      sessionCount = experimentScene.experimentCount + 1;
      allSessionNumber = experimentScene.experimentCountMax;
    }

    textSize(50);
    text(status + ":" + sessionCount +"/"+ allSessionNumber, displayWidth/2, 3*displayHeight/4);

    if (second <= 0 && isPractise)sceneManager.changeScene("Practise");
    if (second <= 0 && !isPractise)sceneManager.changeScene("Experiment");
  }

  void reset() {
    firstMillis = millis();
  }
}
