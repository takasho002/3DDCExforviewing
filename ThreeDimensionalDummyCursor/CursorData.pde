class CursorData {
  Table posDataTable;
  TableRow row;
  String fileName;


  void createDataTable(String name) {
    fileName = name+"/"+name+"_"+nowToString()+".csv";
    posDataTable = new Table();

    posDataTable.addColumn("username");
    posDataTable.addColumn("cursornum");
    posDataTable.addColumn("primary_id");
    posDataTable.addColumn("cursor_id");
    posDataTable.addColumn("x");
    posDataTable.addColumn("y");
    posDataTable.addColumn("z");
    posDataTable.addColumn("azimuthal_rad");
    posDataTable.addColumn("time");
  }

  void createTableRow() {
    row = posDataTable.addRow();
  }

  void setUserName(String name) {
    row.setString("username", name);
  }

  void setCursorNum(int num) {
    row.setInt("cursornum", num);
  }

  void setPrimaryId(int id) {
    row.setInt("primary_id", id);
  }

  void setCursorId(int id) {
    row.setInt("cursor_id", id);
  }

  void setPosition(PVector pos) {
    row.setFloat("x", pos.x);
    row.setFloat("y", pos.y);
    row.setFloat("z", pos.z);
  }

  void setPolarRad(float rad) {
    row.setFloat("polar_rad", rad);
  }

  void setAzimuthalRad(float rad) {
    row.setFloat("azimuthal_rad", rad);
  }

  void setTime(int millis) {
    row.setInt("time", millis);
  }

  //void setSelectedId(int id) {
  //  for (int i = 0; i < posDataTable.getColumnCount(); i++)
  //    posDataTable.setInt(i, "selected_id", id);
  //}

  void save() {
    saveTable(posDataTable, dataPath(fileName));
  }

  String nowToString() {
    return year() + "-"+month() + "-"+day() + "-"+hour() + "-"+minute() + "-"+second();
  }
}
