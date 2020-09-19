part of stagexl_dragonbones;

class SlotAnimation implements AnimationObject {
  @override
  final String name;
  @override
  final List<SlotAnimationFrame> frames;

  SlotAnimation(this.name, this.frames);

  //---------------------------------------------------------------------------

  @override
  String toString() => "AnimationSlot '$name'";
}
