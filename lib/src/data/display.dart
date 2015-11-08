part of stagexl_dragonbones;

class Display {

  final String name;
  final String type;
  final Transform transform = new Transform();

  Display(this.name, this.type);

  @override
  String toString() => "Display($type) '$name' ";
}
