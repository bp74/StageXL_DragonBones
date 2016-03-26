part of stagexl_dragonbones;

class MeshAnimationFrame implements AnimationObjectFrame {

  final int duration;
  final Curve curve;
  final double tweenEasing;

  final int offset;
  final Float32List vertices;

  MeshAnimationFrame(
      this.duration, this.curve, this.tweenEasing,
      this.offset, this.vertices);

}