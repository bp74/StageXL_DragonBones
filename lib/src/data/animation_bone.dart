part of stagexl_dragonbones;

class AnimationBone {

  final String name;
  final List<AnimationBoneFrame> frames = new List<AnimationBoneFrame>();

  AnimationBone(this.name);

  @override
  String toString() => "AnimationBone '$name'";
}
