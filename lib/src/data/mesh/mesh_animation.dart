part of stagexl_dragonbones;

class MeshAnimation implements AnimationObject {

  final String name;
  final String slotName;
  final String skinName;

  final List<MeshAnimationFrame> frames;

  MeshAnimation(this.name, this.slotName, this.skinName, this.frames);
}