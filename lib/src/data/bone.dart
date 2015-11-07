part of stagexl_dragonbones;

class Bone {

  final String name;
  final String parent;
  final String length;
  final Transform transform = new Transform();

  Bone(this.name, this.parent, this.length);

}
