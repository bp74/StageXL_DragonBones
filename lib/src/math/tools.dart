part of stagexl_dragonbones;

double _getEaseValue(double value, double easing) {

  double valueEase = 1.0;

  if (easing > 1.0) {
    //ease in out
    valueEase = 0.5 * (1.0 - math.cos(value * math.PI));
    easing -= 1.0;
  } else if (easing > 0.0) {
    //ease out
    valueEase = 1.0 - math.pow(1 - value, 2);
  } else if (easing < 0.0) {
    //ease in
    easing *= -1.0;
    valueEase = math.pow(value, 2.0);
  }

  return (valueEase - value) * easing + value;
}
