part of stagexl_dragonbones;

class SlotAnimation implements AnimationObject {

  final String name;
  final List<SlotAnimationFrame> frames;

  SlotAnimation(this.name, this.frames);

  //---------------------------------------------------------------------------

  @override
  String toString() => "AnimationSlot '$name'";
}
