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

  @override
  String toString() =>
      "Transform x:$x, y:$y, "+
      "skewX:$skewX, skewY:$skewY, "+
      "scaleX:$scaleX, scaleY:$scaleY";
}
