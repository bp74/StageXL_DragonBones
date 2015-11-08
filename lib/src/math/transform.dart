part of stagexl_dragonbones;

class Transform {

  double _x = 0.0;
  double _y = 0.0;
  double _skewX = 0.0;
  double _skewY = 0.0;
  double _scaleX = 1.0;
  double _scaleY = 1.0;

  bool _refreshMatrix = true;
  final Matrix _matrix = new Matrix.fromIdentity();

  //---------------------------------------------------------------------------

  /// Position on the x axis.

  double get x => _x;

  set x(double value) {
    _x = value;
    _refreshMatrix = true;
  }

  /// Position on the y axis.

  double get y => _y;

  set y(double value) {
    _y = value;
    _refreshMatrix = true;
  }

  //  skew on the x axis.

  double get skewX => _skewX;

  set skewX(double value) {
    _skewX = value;
    _refreshMatrix = true;
  }

  /// skew on the y axis.

  double get skewY => _skewY;

  set skewY(double value) {
    _skewY = value;
    _refreshMatrix = true;
  }

  /// Scale on the x axis.

  double get scaleX => _scaleX;

  set scaleX(double value) {
    _scaleX = value;
    _refreshMatrix = true;
  }

  /// Scale on the y axis.

  double get scaleY => _scaleY;

  set scaleY(double value) {
    _scaleY = value;
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
    _x = 0.0;
    _y = 0.0;
    _skewX = 0.0;
    _skewY = 0.0;
    _scaleX = 1.0;
    _scaleY = 1.0;
    _refreshMatrix = true;
  }

  //---------------------------------------------------------------------------

  void copyFrom(Transform t) {
    _x = t.x;
    _y = t.y;
    _skewX = t.skewX;
    _skewY = t.skewY;
    _scaleX = t.scaleX;
    _scaleY = t.scaleY;
    _refreshMatrix = true;
  }

  //---------------------------------------------------------------------------

  void tween(Transform t1, Transform t2, double value) {
    _x = t1.x + (t2.x - t1.x) * value;
    _y = t1.y + (t2.y - t1.y) * value;
    _skewX = t1.skewX + (t2.skewX - t1.skewX) * value;
    _skewY = t1.skewY + (t2.skewY - t1.skewY) * value;
    _scaleX = t1.scaleX + (t2.scaleX - t1.scaleX) * value;
    _scaleY = t1.scaleY + (t2.scaleY - t1.scaleY) * value;
    _refreshMatrix = true;
  }

  //---------------------------------------------------------------------------

  void append(Transform t) {
    _x = _x + t.x;
    _y = _y + t.y;
    _skewX = _skewX + t.skewX;
    _skewY = _skewY + t.skewY;
    _scaleX = _scaleX * t.scaleX;
    _scaleY = _scaleY * t.scaleY;
    _refreshMatrix = true;
  }

  //---------------------------------------------------------------------------

  @override
  String toString() =>
      "Transform x:$x, y:$y, "+
      "skewX:$skewX, skewY:$skewY, "+
      "scaleX:$scaleX, scaleY:$scaleY";
}

