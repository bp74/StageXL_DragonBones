part of stagexl_dragonbones;

class Animation {

  final String name;
  final int duration;
  final int playTimes;

  final List<AnimationSlot> slots;
  final List<AnimationBone> bones;

  Animation(
      this.name,
      this.duration,
      this.playTimes,
      this.bones,
      this.slots);

  //---------------------------------------------------------------------------

  @override
  String toString() => "Animation '$name'";
}
