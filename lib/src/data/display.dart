part of stagexl_dragonbones;

class Display {

  final String name;
  final String type;
  final Transform transform;

  Display(this.name, this.type, this.transform);

  //---------------------------------------------------------------------------

  @override
  String toString() => "Display($type) '$name' ";
}
