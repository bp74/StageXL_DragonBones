part of stagexl_dragonbones;

class MeshAnimation implements AnimationObject {
  @override
  final String name;
  final String slotName;
  final String skinName;

  @override
  final List<MeshAnimationFrame> frames;

  MeshAnimation(this.name, this.slotName, this.skinName, this.frames);
}
