part of stagexl_dragonbones;

class Armature {

  final String name;
  final List<Bone> bones;
  final List<Slot> slots;
  final List<Skin> skins;
  final List<Animation> animations;

  Armature(this.name, this.bones, this.slots, this.skins, this.animations);

  //---------------------------------------------------------------------------

  @override
  String toString() => "Armature '$name'";

}
