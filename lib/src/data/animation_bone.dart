part of stagexl_dragonbones;

class AnimationBone {

  final String name;
  final List<AnimationBoneFrame> frames;

  AnimationBone(this.name, this.frames);

  //---------------------------------------------------------------------------

  @override
  String toString() => "AnimationBone '$name'";
}
