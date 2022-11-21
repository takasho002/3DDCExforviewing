import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Finger;


LeapMotionP5 leap;

//second window
SecondWindow secondwindow;

//SceneManager
SceneManager sceneManager;


//Scenes
StartScene startScene;
CountDown countDown;
PractiseScene practiseScene;
BreakTime breakTime;
ExperimentScene experimentScene;
SelectCursorNumber selectCursorNumberScene;
FinishScene finishScene;

//const
final int settionNum = 5;
final int[] cursornums = {6, 11, 21, 51};//カーソル数: リアルカーソル+ダミーカーソル数
final int timeLimit = 60000;//60秒


ArrayList<Integer>practiseCursornums = new ArrayList();
int fieldWidth, fieldHeight, fieldDepth;
String username = "satuei";
boolean isPractise;

void settings() {
  fullScreen(P3D, 2);
}

public void setup() {
  secondwindow = new SecondWindow();

  fieldWidth = fieldHeight = fieldDepth = displayHeight;
  
//  setting leap motion
    leap = new LeapMotionP5(this);

  isPractise = true;

  practiseCursornums.add(1);

  for (int cursornum : cursornums)
    practiseCursornums.add(cursornum);


  //scenes' initialization
  sceneManager = new SceneManager();
  startScene = new StartScene();
  countDown = new CountDown();
  practiseScene = new PractiseScene();
  breakTime = new BreakTime();
  experimentScene = new ExperimentScene();
  selectCursorNumberScene = new SelectCursorNumber();
  finishScene = new FinishScene();
}


public void draw() {
  sceneManager.display();
}


public void keyPressed() {
  sceneManager.keyPressed(keyCode);
}


public void stop() {
  leap.stop();
}
