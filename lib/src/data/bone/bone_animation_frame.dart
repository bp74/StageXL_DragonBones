part of stagexl_dragonbones;

class BoneAnimationFrame implements AnimationObjectFrame {
  @override
  final int duration;
  @override
  final Curve curve;
  @override
  final double tweenEasing;

  final Transform transform;

  BoneAnimationFrame(
      this.duration, this.curve, this.tweenEasing, this.transform);
}
