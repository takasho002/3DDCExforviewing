class SelectCursorNumber {
  ArrayList<Button>buttons;
  Table table;
  int selectNumber;
  int cursornum;
  int  buttonsLeftX, buttonsTopY;
  int buttonWidth, buttonHeight;

  SelectCursorNumber() {
    buttonsLeftX = 200;
    buttonsTopY = 50;
    buttonWidth = 150;
    buttonHeight = 80;
    table = new Table();
    table.addColumn("id");
    table.addColumn("cursornum");
    table.addColumn("time");
    table.addColumn("selectNum");
    table.addColumn("currentNum");
  }

  void display(PGraphics pg) {
    pg.background(255);
    pg.textSize(30);
    if (!experimentScene.isTimeOver()) {
      pg.textAlign(LEFT, TOP);
      pg.fill(0);
      pg.text(nf(experimentScene.elapsedSeconds, 2, 2), 50, 50);
    } else {
      pg.textAlign(LEFT, TOP);
      pg.fill(255, 0, 0);
      pg.text("Time Over", 50, 50);
    }

    for (Button button : buttons)
      button.display(pg);
  }

  void reset() {
    cursornum = experimentScene.getCursorNum();
    buttons = new ArrayList();
    selectNumber = -1;

    for (int i = 0; i < cursornum; i++) {
      float x = buttonWidth*(i/10) + buttonsLeftX;
      float y = buttonHeight*(i%10) + buttonsTopY;

      Button button = new Button();
      button.setNumber(i);
      button.setPosition(x, y);
      button.setRange(buttonWidth, buttonHeight);

      buttons.add(button);
    }
  }

  void mousePressed(PApplet applet) {
    if (experimentScene.isCursorPlaying())return;
    if (experimentScene.isTimeOver())return;
    for (Button button : buttons) {
      if (button.mouseInRange(applet)) {
        selectNumber = button.getNumber();
        button.select();
      } else {
        button.cancel();
      }
    }
  }

  void addRow() {
    TableRow row = table.addRow();
    row.setInt("id", table.lastRowIndex());
    row.setFloat("cursornum", experimentScene.getCursorNum());
    row.setFloat("time", experimentScene.getTime());
    row.setFloat("currentNum", experimentScene.getCorrectNum());
    row.setFloat("selectNum", selectNumber);
  }

  void save() {
    saveTable(table, "data/"+username+"/checkNumberMaching.csv");
  }
}


class Button {
  int num;
  float x, y;
  float width, height;
  color rectStrokeColor, rectFillColor, strColor;

  Button() {
    rectStrokeColor = color(0);
    rectFillColor = color(255);
    strColor = color(0);
  }

  void display(PGraphics pg) {
    pg.textAlign(CENTER, CENTER);


    pg.stroke(rectStrokeColor);
    pg.fill(rectFillColor);
    pg.rect(this.x, this.y, this.width, this.height);

    pg.textSize(40);
    pg.fill(strColor);
    pg.text(num, x + width/2, y+height/2);
  }

  void setPosition(float _x, float _y) {
    x = _x;
    y = _y;
  }

  void setRange(float _width, float _height) {
    width = _width;
    height = _height;
  }

  void setNumber(int _num) {
    num = _num;
  }

  void select() {
    rectFillColor = color(255, 0, 0);
    strColor = color(255);
  }

  void cancel() {
    rectFillColor = color(255);
    strColor = color(0);
  }

  int getNumber() {
    return num;
  }

  boolean mouseInRange(PApplet applet) {
    return applet.mouseX > x && applet.mouseY > y && applet.mouseX < x + width&&applet.mouseY < y + height;
  }
}
