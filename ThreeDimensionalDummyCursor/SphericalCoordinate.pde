static class SphericalCoordinate {

  static float radius(PVector pos) {
    return pos.mag();
  }

  static float polarRad(PVector pos) {
    return acos(pos.x/pos.mag());
  }

  static float azimuthalRad(PVector pos) {
    return sgn(pos.y)*acos(pos.z/mag(pos.z, pos.y));
  }

  static int sgn(float y) {
    if (y >= 0)return 1;
    else return -1;
  }
}
