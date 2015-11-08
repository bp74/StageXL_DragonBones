part of stagexl_dragonbones;

class Skin {

  final String name;
  final List<SkinSlot> slots;

  Skin(this.name, this.slots);

  @override
  String toString() => "Skin '$name'";
}
