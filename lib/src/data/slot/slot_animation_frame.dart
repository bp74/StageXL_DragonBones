part of stagexl_dragonbones;

class SlotAnimationFrame implements AnimationObjectFrame {
  @override
  final int duration;
  @override
  final Curve curve;
  @override
  final double tweenEasing;

  final ColorTransform colorTransform;
  final int displayIndex;
  final int zOrder;

  SlotAnimationFrame(this.duration, this.curve, this.tweenEasing,
      this.colorTransform, this.displayIndex, this.zOrder);
}
