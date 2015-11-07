part of stagexl_dragonbones;

class DragonBones {

  String name = "";
  String version = "";
  int frameRate = 24;
  bool isGlobal = false;

  final List<Armature> armatures = new List<Armature>();

  static DragonBones fromJson(String json, TextureAtlas textureAtlas) {
    var data = JSON.decode(json);
    var version = data["version"];
    if (version == "4.0") return _DragonBonesParserJson4.parse(data);
    throw new ArgumentError("Unsupported format.");
  }

  Armature getArmature(String name) {
    return armatures.firstWhere((a) => a.name == name);
  }
}
