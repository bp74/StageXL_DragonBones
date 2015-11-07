part of stagexl_dragonbones;

class Transform {

  double x = 0.0;
  double y = 0.0;
  double skewX = 0.0;
  double skewY = 0.0;
  double scaleX = 1.0;
  double scaleY = 1.0;

  @override
  String toString() =>
      "Transform x:$x, y:$y, "+
      "skewX:$skewX, skewY:$skewY, "+
      "scaleX:$scaleX, scaleY:$scaleY";
}
