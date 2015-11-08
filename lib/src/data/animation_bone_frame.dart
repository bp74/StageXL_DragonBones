part of stagexl_dragonbones;

class AnimationBoneFrame {

  // tweenEasing
  // null    : no tween
  // 10      :auto tween,
  // [-1, 0) :ease in,
  // 0       :line easing,
  // (0, 1]  :ease out,
  // (1, 2]  :ease in out

  final int duration;
  final int tweenEasing;
  final Transform transform;

  AnimationBoneFrame(
      this.duration,
      this.tweenEasing,
      this.transform);

}
