part of stagexl_dragonbones;

class Bone {

  final String name;
  final String parent;
  final int length;
  final Transform transform;

  Bone(this.name, this.parent, this.length, this.transform);

  //---------------------------------------------------------------------------

  @override
  String toString() => "Bone '$name'";
}
