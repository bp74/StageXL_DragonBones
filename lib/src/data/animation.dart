part of stagexl_dragonbones;

class Animation {

  final String name;
  final int duration;
  final int playTimes;

  final List<AnimationSlot> slots = new List<AnimationSlot>();
  final List<AnimationBone> bones = new List<AnimationBone>();
  final List<AnimationFrame> frames = new List<AnimationFrame>();

  Animation(this.name, this.duration, this.playTimes);

}
