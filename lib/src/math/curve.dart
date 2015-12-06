part of stagexl_dragonbones;

/// A cubic bezier implementation for easing.
///
/// Example: http://cubic-bezier.com/

class Curve {

  final double x0 = 0.0;
  final double y0 = 0.0;
  final double x1;
  final double y1;
  final double x2;
  final double y2;
  final double x3 = 1.0;
  final double y3 = 1.0;

  final Float32List _values = new Float32List(20);

  Curve(this.x1, this.y1, this.x2, this.y2) {
    if (x1 < 0.0 || x1 > 1.0) throw new RangeError.value(x1, "x1");
    if (x2 < 0.0 || x2 > 1.0) throw new RangeError.value(x2, "x2");
    for(int i = 0; i < _values.length; i++) {
      var x = i / (_values.length - 1);
      var y = _calculate(x, x1, y1, x2, y2);
      _values[i] = y;
    }
  }

  double getValue(double x) {
    if (x <= 0.0) {
      return 0.0;
    } else if (x >= 1.0) {
      return 1.0;
    } else if (isLinear) {
      return x;
    } else {
      var ir = x * (_values.length - 1);
      var im = ir % 1.0;
      var v0 = _values[ir.floor()];
      var v1 = _values[ir.ceil()];
      return v0 * (1.0 - im) + v1 * im;
    }
  }

  bool get isCurve {
    return x1 != 0.0 || y1 != 0.0 || x2 != 1.0 || y2 != 1.0;
  }

  bool get isLinear {
    return x1 == 0.0 && y1 == 0.0 && x2 == 1.0 && y2 == 1.0;
  }

  //---------------------------------------------------------------------------

  double _calculate(double x, double x1, double y1, double x2, double y2) {

    // http://www.flong.com/texts/code/shapers_bez/

    var a = 1.0 * x3 - 3.0 * x2 + 3.0 * x1 - 1.0 * x0;
    var b = 3.0 * x2 - 6.0 * x1 + 3.0 * x0;
    var c = 3.0 * x1 - 3.0 * x0;
    var d = 1.0 * x0;

    // Using Newton-Raphson to solve for t given x
    // Assume for the first guess that t = x

    var refinementIterations = 5;
    var t = x;

    for (int i = 0; i < refinementIterations; i++) {
      var u = t * (t * (t * a + b) + c) + d;
      var s = t * (t * a * 3.0 + b * 2.0) + c;
      if (s == 0.0) break;
      t = t - (u - x) / s;
      if (t < 0.0) t = 0.0;
      if (t > 1.0) t = 1.0;
    }

    // Solve for y given t

    a = 1.0 * y3 - 3.0 * y2 + 3.0 * y1 - 1.0 * y0;
    b = 3.0 * y2 - 6.0 * y1 + 3.0 * y0;
    c = 3.0 * y1 - 3.0 * y0;
    d = 1.0 * y0;

    return t * (t * (t * a + b) + c) + d;
  }

}

