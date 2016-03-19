part of stagexl_dragonbones;

class AnimationFfdFrame {

  // tweenEasing
  // null    : no tween
  // 10      :auto tween,
  // [-1, 0) :ease in,
  // 0       :line easing,
  // (0, 1]  :ease out,
  // (1, 2]  :ease in out

  final int duration;
  final int offset;
  final Float32List vertices;
  final double tweenEasing;
  final Curve curve;

  AnimationFfdFrame(
      this.duration,
      this.offset,
      this.vertices,
      this.tweenEasing,
      this.curve);

}