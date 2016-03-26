part of stagexl_dragonbones;

class BoneAnimationFrame implements AnimationObjectFrame {

  final int duration;
  final Curve curve;
  final double tweenEasing;

  final Transform transform;

  BoneAnimationFrame(
      this.duration, this.curve, this.tweenEasing,
      this.transform);

}
