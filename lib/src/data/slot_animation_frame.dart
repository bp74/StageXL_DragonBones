part of stagexl_dragonbones;

class SlotAnimationFrame {

  // tweenEasing
  // null    : no tween
  // 10      :auto tween,
  // [-1, 0) :ease in,
  // 0       :line easing,
  // (0, 1]  :ease out,
  // (1, 2]  :ease in out

  final int duration;
  final double tweenEasing;
  final int displayIndex;
  final int zOrder;
  final ColorTransform colorTransform;
  final Curve curve;

  SlotAnimationFrame(
      this.duration,
      this.tweenEasing,
      this.displayIndex,
      this.zOrder,
      this.colorTransform,
      this.curve);

}
