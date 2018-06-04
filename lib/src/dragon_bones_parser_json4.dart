part of stagexl_dragonbones;

class _DragonBonesParserJson4 {

  // Format: http://edn.egret.com/cn/index.php/article/index/id/338

  static DragonBones parse(Map data) {
    return new DragonBones(
        _getString(data, "name", ""),
        _getString(data, "version", "0.0"),
        _getInt(data, "frameRate", 24),
        _getBool(data, "isGlobal", false),
        _getList<Armature>(data, "armature", _parseArmature));
  }

  //---------------------------------------------------------------------------

  static Armature _parseArmature(Map data) {
    return new Armature(
        _getString(data, "name", ""),
        _getList<Bone>(data, "bone", _parseBone),
        _getList<Slot>(data, "slot", _parseSlot),
        _getList<Skin>(data, "skin", _parseSkin),
        _getList<Animation>(data, "animation", _parseAnimation));
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
        _getInt(data, "displayIndex", 0),
        _getInt(data, "z", 0));
  }

  static Skin _parseSkin(Map data) {
    return new Skin(
        _getString(data, "name", ""),
        _getList<SkinSlot>(data, "slot", _parseSkinSlot));
  }

  static SkinSlot _parseSkinSlot(Map data) {
    return new SkinSlot(
        _getString(data, "name", ""),
        _getList<Display>(data, "display", _parseDisplay));
  }

  static Display _parseDisplay(Map data) {
    var name = _getString(data, "name", "");
    var type = _getString(data, "type", "");
    var transform = _getTransform(data, "transform");

    if (type == "mesh") {
      var vertices = _getFloat32List(data, "vertices", (v) => v.toDouble());
      var uvs = _getFloat32List(data, "uvs", (v) => v.toDouble());
      var triangles = _getInt16List(data, "triangles", (v) => v);
      var edges = _getInt16List(data, "edges", (v) => v);
      return new Mesh(name, type, transform, vertices, uvs, triangles, edges);
    } else {
      return new Display(name, type, transform);
    }
  }

  //---------------------------------------------------------------------------

  static Animation _parseAnimation(Map data) {
    return new Animation(
        _getString(data, "name", ""),
        _getInt(data, "duration", 0),
        _getInt(data, "playTimes", 0),
        _getList<BoneAnimation>(data, "bone", _parseAnimationBone),
        _getList<SlotAnimation>(data, "slot", _parseAnimationSlot),
        _getList<MeshAnimation>(data, "ffd", _parseAnimationMesh));
  }

  static BoneAnimation _parseAnimationBone(Map data) {
    return new BoneAnimation(
        _getString(data, "name", ""),
        _getList<BoneAnimationFrame>(data, "frame", _parseAnimationBoneFrame));
  }

  static SlotAnimation _parseAnimationSlot(Map data) {
    return new SlotAnimation(
        _getString(data, "name", ""),
        _getList<SlotAnimationFrame>(data, "frame", _parseAnimationSlotFrame));
  }

  static MeshAnimation _parseAnimationMesh(Map data) {
    return new MeshAnimation(
        _getString(data, "name", ""),
        _getString(data, "slot", ""),
        _getString(data, "skin", ""),
        _getList<MeshAnimationFrame>(data, "frame", _parseAnimationMeshFrame));
  }

  static BoneAnimationFrame _parseAnimationBoneFrame(Map data) {
    var duration = _getInt(data, "duration", 0);
    var easing = _getDoubleOrNull(data, "tweenEasing", 10.0);
    var transform = _getTransform(data, "transform");
    var curve = _getCurve(data, "curve");
    return new BoneAnimationFrame(duration, curve, easing, transform);
  }

  static SlotAnimationFrame _parseAnimationSlotFrame(Map data) {
    var duration = _getInt(data, "duration", 0);
    var easing = _getDoubleOrNull(data, "tweenEasing", 10.0);
    var displayIndex = _getInt(data, "displayIndex", 0);
    var zOrder = _getInt(data, "z", 0);
    var colorTransform = _getColorTransform(data, "color");
    var curve = _getCurve(data, "curve");
    return new SlotAnimationFrame(
        duration, curve, easing,
        colorTransform, displayIndex, zOrder);
  }

  static MeshAnimationFrame _parseAnimationMeshFrame(Map data) {
    var duration = _getInt(data, "duration", 0);
    var offset = _getInt(data, "offset", 0);
    var vertices = _getFloat32List(data, "vertices", (v) => v.toDouble());
    var easing = _getDoubleOrNull(data, "tweenEasing", 10.0);
    var curve = _getCurve(data, "curve");
    return new MeshAnimationFrame(duration, curve, easing, offset, vertices);
  }

  //---------------------------------------------------------------------------

  static Transform _getTransform(Map data, String key) {
    var value = data.containsKey(key) ? data[key] : new Map();
    var transform = new Transform();
    transform.x = _getDouble(value, "x", 0.0);
    transform.y = _getDouble(value, "y", 0.0);
    transform.skewX = _getDouble(value, "skX", 0.0) * math.pi / 180.0;
    transform.skewY = _getDouble(value, "skY", 0.0) * math.pi / 180.0;
    transform.scaleX = _getDouble(value, "scX", 1.0);
    transform.scaleY = _getDouble(value, "scY", 1.0);
    return transform;
  }

  static Curve _getCurve(Map data, String key) {
    var value = data.containsKey(key) ? data[key] : null;
    if (value is List && value.length == 4) {
      var x1 = value[0].toDouble();
      var y1 = value[1].toDouble();
      var x2 = value[2].toDouble();
      var y2 = value[3].toDouble();
      return new Curve(x1, y1, x2, y2);
    } else {
      return null;
    }
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

  static List<T> _getList<T>(Map<String, dynamic> data, String key, parser) {
    var value = data.containsKey(key) ? data[key] as List : new List();
    return value.map<T>((result) => parser(result)).toList(growable: false);
  }

  static Int16List _getInt16List(Map data, String key, parser) {
    var value = data.containsKey(key) ? data[key] as List : new List();
    var list = value.map<int>((result) => parser(result)).toList(growable: false);
    return new Int16List.fromList(list);
  }

  static Float32List _getFloat32List(Map data, String key, parser) {
    var value = data.containsKey(key) ? data[key] as List : new List();
    var list = value.map<double>((result) => parser(result)).toList(growable: false);
    return new Float32List.fromList(list);
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

  static double _getDoubleOrNull(Map data, String key, double defaultValue) {
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


