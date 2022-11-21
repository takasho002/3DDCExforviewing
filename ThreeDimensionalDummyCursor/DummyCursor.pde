class DummyCursor {
  CursorData cursorData;
  ArrayList<Ball> balls;
  PVector preHandPos;
  boolean isShowed, isMoved;
  int firstMillis, finishMillis;
  IntList cursorIds;

  DummyCursor() {
    cursorData = new CursorData();
    preHandPos = new PVector();
    balls = new ArrayList();
  }

  void init(int cursornum) {
    cursorIds = new IntList();
    for (int i = 0; i < cursornum; i++)
      cursorIds.append(i);
    cursorIds.shuffle();

    cursorData.createDataTable(username);
    setBalls(cursornum);
    isShowed = false;
    isMoved = true;
    firstMillis = millis();
  }

  void display() {
    translate((displayWidth - fieldWidth)/2, 0, 0);
    lights();

    stroke(0);
    fill(255);
    field();

    ArrayList<PVector> fingerPoses = new ArrayList();
    PVector handPos = preHandPos.copy();

    for (Finger finger : leap.getFingerList()) 
      fingerPoses.add(leap.getTip(finger));

    if (fingerPoses.size() < 3 && fingerPoses.size() > 0)
      handPos = fingerPoses.get(0).copy();
    else if (fingerPoses.size() >= 3) 
      handPos = fingerPoses.get(0).copy();

    PVector movedPos = PVector.sub(handPos, preHandPos);

    for (int i = 0; i < balls.size(); i++) {
      Ball ball = balls.get(i);
      if (isMoved)ball.move(movedPos);
      if (isMoved&&!isPractise)trackBallData(ball);
      ball.display();
      if (isShowed)break;
    }

    preHandPos = handPos.copy();
  }


  void field() {


    final int step = 60;    

    for (int z = 0; z >= -fieldDepth; z -= step) {
      line(0, 0, z, fieldWidth, 0, z);
      line(0, fieldHeight, z, fieldWidth, fieldHeight, z);
      line(0, 0, z, 0, fieldHeight, z );
      line(fieldWidth, 0, z, fieldWidth, fieldHeight, z);
    }  



    pushMatrix();
    beginShape();
    vertex(0, 0, 0);
    vertex(0, 0, -fieldDepth);
    vertex(0, fieldHeight, -fieldDepth);
    vertex(0, fieldHeight, 0);
    endShape(CLOSE);    
    popMatrix();

    pushMatrix();
    beginShape();
    vertex(0, 0, 0);
    vertex(0, 0, -fieldDepth);
    vertex(fieldWidth, 0, -fieldDepth);
    vertex(fieldWidth, 0, 0);
    endShape(CLOSE);
    popMatrix();

    pushMatrix();
    beginShape();
    vertex(fieldWidth, 0, 0);
    vertex(fieldWidth, 0, -fieldDepth);
    vertex(fieldWidth, fieldHeight, -fieldDepth);
    vertex(fieldWidth, fieldHeight, 0);
    endShape(CLOSE);
    popMatrix();

    pushMatrix();
    beginShape();
    vertex(0, 0, -fieldDepth);
    vertex(fieldWidth, 0, -fieldDepth);
    vertex(fieldWidth, fieldHeight, -fieldDepth);
    vertex(0, fieldHeight, -fieldDepth);
    endShape(CLOSE);
    popMatrix();

    pushMatrix();
    beginShape();
    vertex(0, fieldHeight, 0);
    vertex(0, fieldHeight, -fieldDepth);
    vertex(fieldWidth, fieldHeight, -fieldDepth);
    vertex(fieldWidth, fieldHeight, 0);
    endShape(CLOSE);
    popMatrix();
  }


  /*-----
   play and stop
   -------*/


  void play() {
    isMoved = true;
  }

  void stop() {
    isMoved = false;
  }

  boolean isPlaying() {
    return isMoved;
  }

  /*-----
   showAnswer()
   -------*/

  void showAnswer() {
    isShowed = true;
  }

  boolean isShowingAnswer() {
    return isShowed;
  }

  /*-----
   show cursor id
   -------*/

  void showCursorIds() {
    for (Ball ball : balls)
      ball.showCursorId();
  }


  /*-----
   set
   -------*/

  void setBalls(int cursornum) {
    balls.clear();
    for (int i = 0; i < cursornum; i++) {
      int cursorId = cursorIds.get(i);

      Ball ball= new Ball();
      ball.init();
      ball.setPrimaryId(i);
      ball.setCursorId(cursorId);

      float polarRad = cursorPolarRad(i, cursornum, 45);
      float azimuthalRad = cursorAzimuthalRad(i, cursornum, 45);
      ball.setRadians(polarRad, azimuthalRad);

      balls.add(ball);
    }
  }

  void setPositions(int left, int right, int top, int bottom, int back, int front) {
    for (Ball b : balls) {
      float x = random(left, right);
      float y = random(top, bottom);
      float z = random(back, front);
      b.setPosition(x, y, z);
    }
  }


  int getRealCursorNum() {
    return cursorIds.get(0);
  }

  int getTime() {
    if (finishMillis < firstMillis)return -1;
    return finishMillis - firstMillis;
  }

  float cursorPolarRad(int _index, int _cursorNum, float _minAngle)
  {
    if (_index == 0)return 0;
    float degree = _minAngle + (_index - 1) * (180 - _minAngle) / (_cursorNum - 2);
    return radians(degree);
  }

  float cursorAzimuthalRad(int _index, int _cursorNum, float _minAngle)
  {
    if (_index == 0)return 0;
    float degree = _minAngle + (_index - 1) * (180 - _minAngle) / (_cursorNum - 2);
    return radians(degree);
  }


  /*-----
   tarck ball data
   -------*/
  void trackBallData(Ball ball) {
    finishMillis = millis();

    cursorData.createTableRow();
    cursorData.setUserName(username);
    cursorData.setCursorNum(balls.size());
    cursorData.setPrimaryId(ball.getPrimaryId());
    cursorData.setCursorId(ball.getCursorId());
    cursorData.setPosition(ball.getPosition());
    cursorData.setAzimuthalRad(ball.getAzimuthalRad());
    cursorData.setTime(millis()-firstMillis ) ;
  }

  void saveData() {
    cursorData.save();
  }
}
