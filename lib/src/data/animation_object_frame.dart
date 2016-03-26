part of stagexl_dragonbones;

abstract class AnimationObjectFrame {

  // tweenEasing
  // null    : no tween
  // 10      :auto tween,
  // [-1, 0) :ease in,
  // 0       :line easing,
  // (0, 1]  :ease out,
  // (1, 2]  :ease in out

  int get duration;
  Curve get curve;
  double get tweenEasing;
}
