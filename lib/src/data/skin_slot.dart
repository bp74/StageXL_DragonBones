part of stagexl_dragonbones;

class SkinSlot {

  final String name;
  final List<Display> displays = new List<Display>();

  SkinSlot(this.name);

  @override
  String toString() => "SkinSlot '$name'";

}
