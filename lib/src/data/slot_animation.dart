part of stagexl_dragonbones;

class SlotAnimation {

  final String name;
  final List<SlotAnimationFrame> frames;

  SlotAnimation(this.name, this.frames);

  //---------------------------------------------------------------------------

  @override
  String toString() => "AnimationSlot '$name'";
}
