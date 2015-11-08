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

  void tween(Transform a, Transform b, double value) {
    _x = a.x + (b.x - a.x) * value;
    _y = a.y + (b.y - a.y) * value;
    _scaleX = a.scaleX + (b.scaleX - a.scaleX) * value;
    _scaleY = a.scaleY + (b.scaleY - a.scaleY) * value;
    _skewX = a.skewX + (b.skewX - a.skewX) * value;
    _skewY = a.skewY + (b.skewY - a.skewY) * value;
    _refreshMatrix = true;
  }

  void tweenToMatrix(Transform a, Transform b, double value, Matrix matrix) {
    double scaleX = a.scaleX + (b.scaleX - a.scaleX) * value;
    double scaleY = a.scaleY + (b.scaleY - a.scaleY) * value;
    double skewX = a.skewX + (b.skewX - a.skewX) * value;
    double skewY = a.skewY + (b.skewY - a.skewY) * value;
    matrix.a = 0.0 + scaleX * math.cos(skewY);
    matrix.b = 0.0 + scaleX * math.sin(skewY);
    matrix.c = 0.0 - scaleY * math.sin(skewX);
    matrix.d = 0.0 + scaleY * math.cos(skewX);
    matrix.tx = a.x + (b.x - a.x) * value;
    matrix.ty = a.y + (b.y - a.y) * value;
  }

  //---------------------------------------------------------------------------

  @override
  String toString() =>
      "Transform x:$x, y:$y, "+
      "skewX:$skewX, skewY:$skewY, "+
      "scaleX:$scaleX, scaleY:$scaleY";
}

