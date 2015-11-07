part of stagexl_dragonbones;

class Armature {

  final String name;

  final List<Bone> bones = new List<Bone>();
  final List<Slot> slots = new List<Slot>();
  final List<Skin> skins = new List<Skin>();
  final List<Animation> animations = new List<Animation>();

  Armature(this.name);

}
