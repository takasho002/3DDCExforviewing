class Ball {
  float x, y, z;//座標
  float polarRotatedRad, azimuthalRotatedRad;//極座標で用いる
  color ballColor;
  boolean isShowCursorNumber;
  int primaryId, cursorId;


  void init() {
    ballColor = color(255);
    isShowCursorNumber = false;
  }

  void display() {  
    fill(ballColor);
    pushMatrix();
    translate(x, y, z);
    noStroke();
    sphere(30);
    if (isShowCursorNumber) {
      translate(0, 0, 30);
      fill(#0085C9);
      textAlign(CENTER, CENTER);
      text(cursorId, 0, 0);
    }

    popMatrix();
  }


  /*-------------------
   move
   ---------------------*/
  void move(PVector _fingerMoveVector) {
    PVector moveVector = getMoveVector(_fingerMoveVector);
    x += moveVector.x;
    y += moveVector.y;
    z += moveVector.z;
    torus();
  }

  void torus() {
    if (x < 0)x = fieldWidth;
    if (x > fieldWidth)x = 0;
    if (y < 0)y = fieldHeight;
    if (y > fieldHeight)y = 0;
    if (z < -fieldDepth)z = 0;
    if (z > 0)z = -fieldDepth;
  }

  PVector getMoveVector(PVector _moveVector) {

    float vector =  _moveVector.mag();
    if (_moveVector == new PVector(0, 0, 0) )return new PVector(0, 0, 0);
    if (_moveVector.x == 0 &&  _moveVector.y == 0) {
      float moveX = vector*sin(azimuthalRotatedRad);
      float moveY = 0;
      float moveZ = vector*cos(azimuthalRotatedRad);
      return new PVector(moveX, moveY, moveZ);
    } else  if (_moveVector.x == 0 && _moveVector.z == 0) {
      float moveX = vector*sin(azimuthalRotatedRad);
      float moveY = vector*cos(azimuthalRotatedRad);
      float moveZ = 0;
      return new PVector(moveX, moveY, moveZ);
    } else  if (_moveVector.y == 0 && _moveVector.z == 0) {
      float moveX = vector*cos(azimuthalRotatedRad);
      float moveY = vector*sin(azimuthalRotatedRad);
      float moveZ = 0;
      return new PVector(moveX, moveY, moveZ);
    } else {
      float polarRad = SphericalCoordinate.polarRad(_moveVector) + polarRotatedRad;
      float azimuthalRad = SphericalCoordinate.azimuthalRad(_moveVector) + azimuthalRotatedRad;
      float moveX = vector*cos(polarRad);
      float moveY = vector*sin(polarRad)*sin(azimuthalRad);
      float moveZ = vector*sin(polarRad)*cos(azimuthalRad);
      return new PVector(moveX, moveY, moveZ);
    }
  }

  /*-------------------
   show cursor id
   ---------------------*/

  void showCursorId() {
    isShowCursorNumber = true;
  }

  /*-------------------
   set
   ---------------------*/
  void setPosition(float _x, float _y, float _z) {
    x = _x;
    y = _y;
    z = _z;
  }


  void setRadians(float _polarRotatedRad, float _azimuthalRad) {
    polarRotatedRad = _polarRotatedRad;
    azimuthalRotatedRad = _azimuthalRad;
  }

  void setPrimaryId(int id) {
    primaryId = id;
  }

  void setCursorId(int id) {
    cursorId = id;
  }

  /*-------------------
   get
   ---------------------*/

  PVector getPosition() {
    return new PVector(x, y, z);
  }

  float getAzimuthalRad() {
    return azimuthalRotatedRad;
  }

  int getPrimaryId() {
    return primaryId;
  }


  int getCursorId() {
    return cursorId;
  }
}
