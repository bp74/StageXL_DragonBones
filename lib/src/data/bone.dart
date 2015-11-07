part of stagexl_dragonbones;

class Bone {

  final String name;

  String parent = "";
  int length = 0;
  Transform transform = new Transform();

  Bone(this.name);

  @override
  String toString() => "Bone '$name'";
}
