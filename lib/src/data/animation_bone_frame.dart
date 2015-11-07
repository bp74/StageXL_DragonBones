part of stagexl_dragonbones;

class AnimationBoneFrame {

  // tweenEasing
  // null    : no tween
  // 10      :auto tween,
  // [-1, 0) :ease in,
  // 0       :line easing,
  // (0, 1]  :ease out,
  // (1, 2]  :ease in out

  final int tweenEasing;
  final int duration;
  final Transform transform = new Transform();

  AnimationBoneFrame(this.tweenEasing, this.duration);

}
