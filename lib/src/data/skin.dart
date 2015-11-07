part of stagexl_dragonbones;

class Skin {

  final String name;
  final List<SkinSlot> slots = new List<SkinSlot>();

  Skin(this.name);

  @override
  String toString() => "Skin '$name'";
}
