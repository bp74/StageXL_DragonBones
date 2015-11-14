part of stagexl_dragonbones;

class DragonBones {

  final String name;
  final String version;
  final int frameRate;
  final bool isGlobal;
  final List<Armature> armatures;

  DragonBones(
      this.name,
      this.version,
      this.frameRate,
      this.isGlobal,
      this.armatures);

  //---------------------------------------------------------------------------

  static DragonBones fromJson(String json) {
    var data = JSON.decode(json);
    var version = data["version"];
    if (version == "4.0") return _DragonBonesParserJson4.parse(data);
    throw new ArgumentError("Unsupported format.");
  }

  //---------------------------------------------------------------------------

  Armature getArmature(String name) {
    return armatures.firstWhere((a) => a.name == name);
  }

  Skeleton createSkeleton(String armatureName) {
    var armature = this.getArmature(armatureName);
    return new Skeleton(armature);
  }

}
