part of stagexl_dragonbones;

class Slot {

  final String name;

  String parent = "";
  int z = 0;

  Slot(this.name);

  @override
  String toString() => "Slot '$name'";

}
