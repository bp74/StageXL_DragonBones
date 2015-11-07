part of stagexl_dragonbones;

class Animation {

  final String name;
  final List<AnimationSlot> slots = new List<AnimationSlot>();
  final List<AnimationBone> bones = new List<AnimationBone>();

  int duration = 0;
  int playTimes = 0;

  Animation(this.name);

  @override
  String toString() => "Animation '$name'";
}
