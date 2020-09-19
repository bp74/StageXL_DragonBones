part of stagexl_dragonbones;

class MeshAnimationFrame implements AnimationObjectFrame {
  @override
  final int duration;
  @override
  final Curve curve;
  @override
  final double tweenEasing;

  final int offset;
  final Float32List vertices;

  MeshAnimationFrame(
      this.duration, this.curve, this.tweenEasing, this.offset, this.vertices);
}
