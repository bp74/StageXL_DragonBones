part of stagexl_dragonbones;

class AnimationSlot {

  final String name;
  final List<AnimationSlotFrame> frames;

  AnimationSlot(this.name, this.frames);

  //---------------------------------------------------------------------------

  @override
  String toString() => "AnimationSlot '$name'";
}
