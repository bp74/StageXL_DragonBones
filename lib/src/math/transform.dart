part of stagexl_dragonbones;

class Transform {
  final Float32List _data = Float32List(6);
  final Matrix _matrix = Matrix.fromIdentity();
  bool _refreshMatrix = true;

  Transform() {
    x = 0.0;
    y = 0.0;
    skewX = 0.0;
    skewY = 0.0;
    scaleX = 1.0;
    scaleY = 1.0;
  }

  //---------------------------------------------------------------------------

  /// Position on the x axis.

  double get x => _data[0];

  set x(double value) {
    _data[0] = value;
    _refreshMatrix = true;
  }

  /// Position on the y axis.

  double get y => _data[1];

  set y(double value) {
    _data[1] = value;
    _refreshMatrix = true;
  }

  //  skew on the x axis.

  double get skewX => _data[2];

  set skewX(double value) {
    _data[2] = value;
    _refreshMatrix = true;
  }

  /// skew on the y axis.

  double get skewY => _data[3];

  set skewY(double value) {
    _data[3] = value;
    _refreshMatrix = true;
  }

  /// Scale on the x axis.

  double get scaleX => _data[4];

  set scaleX(double value) {
    _data[4] = value;
    _refreshMatrix = true;
  }

  /// Scale on the y axis.

  double get scaleY => _data[5];

  set scaleY(double value) {
    _data[5] = value;
    _refreshMatrix = true;
  }

  /// The matrix based on the transformation values.

  Matrix get matrix {
    if (_refreshMatrix) {
      _matrix.a = 0.0 + scaleX * math.cos(skewY);
      _matrix.b = 0.0 + scaleX * math.sin(skewY);
      _matrix.c = 0.0 - scaleY * math.sin(skewX);
      _matrix.d = 0.0 + scaleY * math.cos(skewX);
      _matrix.tx = x;
      _matrix.ty = y;
    }

    return _matrix;
  }

  //---------------------------------------------------------------------------

  void reset() {
    _data[0] = 0.0;
    _data[1] = 0.0;
    _data[2] = 0.0;
    _data[3] = 0.0;
    _data[4] = 1.0;
    _data[5] = 1.0;
    _refreshMatrix = true;
  }

  //---------------------------------------------------------------------------

  void copyFrom(Transform t) {
    _data[0] = t.x;
    _data[1] = t.y;
    _data[2] = t.skewX;
    _data[3] = t.skewY;
    _data[4] = t.scaleX;
    _data[5] = t.scaleY;
    _refreshMatrix = true;
  }

  //---------------------------------------------------------------------------

  void interpolate(Transform t1, Transform t2, double value) {
    _data[0] = t1.x + (t2.x - t1.x) * value;
    _data[1] = t1.y + (t2.y - t1.y) * value;
    _data[2] = t1.skewX + (t2.skewX - t1.skewX) * value;
    _data[3] = t1.skewY + (t2.skewY - t1.skewY) * value;
    _data[4] = t1.scaleX + (t2.scaleX - t1.scaleX) * value;
    _data[5] = t1.scaleY + (t2.scaleY - t1.scaleY) * value;
    _refreshMatrix = true;
  }

  //---------------------------------------------------------------------------

  void concat(Transform t) {
    _data[0] += t.x;
    _data[1] += t.y;
    _data[2] += t.skewX;
    _data[3] += t.skewY;
    _data[4] *= t.scaleX;
    _data[5] *= t.scaleY;
    _refreshMatrix = true;
  }

  //---------------------------------------------------------------------------

  @override
  String toString() =>
      'Transform x:$x, y:$y, skewX:$skewX, skewY:$skewY, scaleX:$scaleX, scaleY:$scaleY';
}
