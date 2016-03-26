part of stagexl_dragonbones;

class Slot {

  final String name;
  final String parent;
  final int zOrder;

  Slot(this.name, this.parent, this.zOrder);

  //---------------------------------------------------------------------------

  @override
  String toString() => "Slot '$name'";

}
