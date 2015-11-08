part of stagexl_dragonbones;

class _DragonBonesParserJson4 {

  static DragonBones parse(Map data) {
    return new DragonBones(
        _getString(data, "name", ""),
        _getString(data, "version", "0.0"),
        _getInt(data, "frameRate", 24),
        _getBool(data, "isGlobal", false),
        _getList(data, "armature", _parseArmature));
  }

  //---------------------------------------------------------------------------

  static Armature _parseArmature(Map data) {
    return new Armature(
        _getString(data, "name", ""),
        _getList(data, "bone", _parseBone),
        _getList(data, "slot", _parseSlot),
        _getList(data, "skin", _parseSkin),
        _getList(data, "animation", _parseAnimation));
  }

  static Bone _parseBone(Map data) {
    return new Bone(
        _getString(data, "name", ""),
        _getString(data, "parent", ""),
        _getInt(data, "length", 0),
        _getTransform(data, "transform"));
  }

  static Slot _parseSlot(Map data) {
    return new Slot(
        _getString(data, "name", ""),
        _getString(data, "parent", null),
        _getInt(data, "z", 0));
  }

  static Skin _parseSkin(Map data) {
    return new Skin(
        _getString(data, "name", ""),
        _getList(data, "slot", _parseSkinSlot));
  }

  static SkinSlot _parseSkinSlot(Map data) {
    return new SkinSlot(
        _getString(data, "name", ""),
        _getList(data, "display", _parseDisplay));
  }

  static Display _parseDisplay(Map data) {
    return new Display(
        _getString(data, "name", ""),
        _getString(data, "type", ""),
        _getTransform(data, "transform"));
  }

  //---------------------------------------------------------------------------

  static Animation _parseAnimation(Map data) {
    return new Animation(
        _getString(data, "name", ""),
        _getInt(data, "duration", 0),
        _getInt(data, "playTimes", 0),
        _getList(data, "bone", _parseAnimationBone),
        _getList(data, "slot", _parseAnimationSlot));
  }

  static AnimationBone _parseAnimationBone(Map data) {
    return new AnimationBone(
        _getString(data, "name", ""),
        _getList(data, "frame", _parseAnimationBoneFrame));
  }

  static AnimationSlot _parseAnimationSlot(Map data) {
    return new AnimationSlot(
        _getString(data, "name", ""),
        _getList(data, "frame", _parseAnimationSlotFrame));
  }

  static AnimationBoneFrame _parseAnimationBoneFrame(Map data) {
    return new AnimationBoneFrame(
        _getInt(data, "duration", 0),
        _getDoubleOrNull(data, "tweenEasing", 10),
        _getTransform(data, "transform"));
  }

  static AnimationSlotFrame _parseAnimationSlotFrame(Map data) {
    return new AnimationSlotFrame(
        _getInt(data, "duration", 0),
        _getDoubleOrNull(data, "tweenEasing", 10),
        _getInt(data, "displayIndex", 0),
        _getInt(data, "z", 0),
        _getColorTransform(data, "color"));
  }

  //---------------------------------------------------------------------------

  static Transform _getTransform(Map data, String key) {
    var value = data.containsKey(key) ? data[key] : new Map();
    var transform = new Transform();
    transform.x = _getDouble(value, "x", 0.0);
    transform.y = _getDouble(value, "y", 0.0);
    transform.skewX = _getDouble(value, "skX", 0.0) * math.PI / 180.0;
    transform.skewY = _getDouble(value, "skY", 0.0) * math.PI / 180.0;
    transform.scaleX = _getDouble(value, "scX", 1.0);
    transform.scaleY = _getDouble(value, "scY", 1.0);
    return transform;
  }

  static ColorTransform _getColorTransform(Map data, String key) {
    var value = data.containsKey(key) ? data[key] : new Map();
    var colorTransform = new ColorTransform();
    colorTransform.alphaOffset = _getInt(value, "aO", 0);
    colorTransform.redOffset = _getInt(value, "rO", 0);
    colorTransform.greenOffset = _getInt(value, "gO", 0);
    colorTransform.blueOffset = _getInt(value, "bO", 0);
    colorTransform.alphaMultiplier = _getInt(value, "aM", 100) * 0.01;
    colorTransform.redMultiplier = _getInt(value, "rM", 100) * 0.01;
    colorTransform.greenMultiplier = _getInt(value, "gM", 100) * 0.01;
    colorTransform.blueMultiplier = _getInt(value, "bM", 100) * 0.01;
    return colorTransform;
  }

  static List _getList(Map data, String key, parser) {
    var value = data.containsKey(key) ? data[key] : new List();
    return value.map(parser).toList(growable: false);
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

  static double _getDoubleOrNull(Map data, String key, int defaultValue) {
    var value = data.containsKey(key) ? data[key] : defaultValue;
    if (value is num) return value.toDouble();
    if (value == null) return null;
    throw new StateError("Invalid type for key '$key'");
  }

  static double _getDouble(Map data, String key, double defaultValue) {
    var value = data.containsKey(key) ? data[key] : defaultValue;
    if (value is num) return value.toDouble();
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


