part of stagexl_dragonbones;

class AnimationSlotFrame {

  // tweenEasing
  // null    : no tween
  // 10      :auto tween,
  // [-1, 0) :ease in,
  // 0       :line easing,
  // (0, 1]  :ease out,
  // (1, 2]  :ease in out

  int z = 0;
  int duration = 0;
  int tweenEasing = 0;
  int displayIndex = 0;

  final ColorTransform colorTransform = new ColorTransform();

}
