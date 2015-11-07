part of stagexl_dragonbones;

class DragonBones {

  String name = "";
  String version = "";
  int frameRate = 24;
  bool isGlobal = false;

  final List<Armature> armatures = new List<Armature>();

  static DragonBones fromJson(String json, TextureAtlas textureAtlas) {
    var data = JSON.decode(json);
    return _DragonBonesJson4Format.parse(data);
  }

  Armature getArmature(String name) {
    return armatures.firstWhere((a) => a.name == name);
  }
}

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

class _DragonBonesJson4Format {

  static DragonBones parse(Map data) {

    var dragonBones = new DragonBones();
    dragonBones.name = _getString(data, "name", "");
    dragonBones.version = _getString(data, "version", "0.0");
    dragonBones.frameRate = _getInt(data, "frameRate", 24);
    dragonBones.isGlobal = _getBool(data, "isGlobal", false);

    var armatures = data["armature"].map(_parseArmature);
    dragonBones.armatures.addAll(armatures);

    return dragonBones;
  }

  //---------------------------------------------------------------------------

  static Armature _parseArmature(Map data) {

    var name = _getString(data, "name", "");
    var armature = new Armature(name);

    var bones = data["bone"].map(_parseBone);
    var slots = data["slot"].map(_parseSlot);
    var skins = data["skin"].map(_parseSkin);
    var animations = data["animation"].map(_parseAnimation);

    armature.bones.addAll(bones);
    armature.slots.addAll(slots);
    armature.skins.addAll(skins);
    armature.animations.addAll(animations);

    return armature;
  }

  static Bone  _parseBone(Map data) {
    return null;
  }

  static Slot _parseSlot(Map data) {
    return null;
  }

  static Skin _parseSkin(Map data) {
    return null;
  }

  static Animation _parseAnimation(Map data) {
    return null;
  }

  //---------------------------------------------------------------------------

  static String _getString(Map data, String key, String defaultValue) {
    var value = data.containsKey(key) ? data[key] : defaultValue;
    if (value is String) return value;
    throw new StateError("Invalid type for key '$key'");
  }

  static int _getInt(Map data, String key, int defaultValue) {
    var value = data.containsKey(key) ? data[key] : defaultValue;
    if (value is int) return value;
    throw new StateError("Invalid type for key '$key'");
  }

  static bool _getBool(Map data, String key, bool defaultValue) {
    var value = data.containsKey(key) ? data[key] : defaultValue;
    if (value is bool) return value;
    if (value == 0 || value == "false") return false;
    if (value == 1 || value == "true") return true;
    throw new StateError("Invalid type for key '$key'");
  }

}


