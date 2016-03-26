part of stagexl_dragonbones;

class BoneAnimation implements AnimationObject {

  final String name;
  final List<BoneAnimationFrame> frames;

  BoneAnimation(this.name, this.frames);

  //---------------------------------------------------------------------------

  @override
  String toString() => "AnimationBone '$name'";
}
