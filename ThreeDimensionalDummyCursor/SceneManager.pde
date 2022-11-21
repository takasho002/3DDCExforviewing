enum Scene {
  START, 
    COUNT_DOWN, 
    PRACTISE, 
    BREAK_TIME, 
    EXPERIMENT, 
    FINISH
}

class SceneManager {
  Scene scene;
  SceneManager() {
    scene = Scene.START;
  }

  void display() {
    background(0);
    switch(scene) {
    case START:
      startScene.display();
      break;
    case COUNT_DOWN:
      countDown.display();
      break;
    case PRACTISE:
      practiseScene.display();
      break;
    case BREAK_TIME:
      breakTime.display();
      break;
    case EXPERIMENT:
      experimentScene.display();
      break;
    case FINISH:
      finishScene.display();
      break;
    default:
      break;
    }
  }

  void secondDisplay(PGraphics pg) {
    switch(scene) {
    case EXPERIMENT:
      selectCursorNumberScene.display(pg);
      break;
    default:
      pg.background(255);
      break;
    }
  }

  void mousePressed(PApplet applet) {
    switch(scene) {
    case EXPERIMENT:
      selectCursorNumberScene.mousePressed(applet);
      break;
    default:
      break;
    }
  }


  void keyPressed(int _keyCode) {
    switch(scene) {
    case START:
      startScene.keyPressed(_keyCode);
      break;
    case PRACTISE:
      practiseScene.keyPressed(_keyCode);
      break;
    case BREAK_TIME:
      breakTime.keyPressed(_keyCode);
      break;
    case EXPERIMENT:
      experimentScene.keyPressed(_keyCode);
      break;
    default:
      break;
    }
  }

  void changeScene(String sceneName) {

    switch(sceneName) {
    case "CountDown":
      scene = Scene.COUNT_DOWN;
      countDown.reset();
      break;
    case "Practise":
      scene = Scene.PRACTISE;
      practiseScene.init();
      break;
    case "BreakTime":
      scene = Scene.BREAK_TIME;
      break;
    case "Experiment":
      scene = Scene.EXPERIMENT;
      experimentScene.init();
      selectCursorNumberScene.reset();
      break;
    case "Finish":
      scene = Scene.FINISH;
      break;
    default:
      break;
    }
  }
}
