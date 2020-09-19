part of stagexl_dragonbones;

class BoneAnimation implements AnimationObject {
  @override
  final String name;
  @override
  final List<BoneAnimationFrame> frames;

  BoneAnimation(this.name, this.frames);

  //---------------------------------------------------------------------------

  @override
  String toString() => "AnimationBone '$name'";
}
