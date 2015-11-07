part of stagexl_dragonbones;

class _DragonBonesParserJson4 {

  static DragonBones parse(Map data) {
    var dragonBones = new DragonBones();
    dragonBones.name = _getString(data, "name", "");
    dragonBones.version = _getString(data, "version", "0.0");
    dragonBones.frameRate = _getInt(data, "frameRate", 24);
    dragonBones.isGlobal = _getBool(data, "isGlobal", false);
    dragonBones.armatures.addAll(data["armature"].map(_parseArmature));
    return dragonBones;
  }

  //---------------------------------------------------------------------------

  static Armature _parseArmature(Map data) {
    var name = _getString(data, "name", "");
    var armature = new Armature(name);
    armature.bones.addAll(data["bone"].map(_parseBone));
    armature.slots.addAll(data["slot"].map(_parseSlot));
    armature.skins.addAll(data["skin"].map(_parseSkin));
    armature.animations.addAll(data["animation"].map(_parseAnimation));
    return armature;
  }

  //---------------------------------------------------------------------------

  static Bone _parseBone(Map data) {
    var name = _getString(data, "name", "");
    var bone = new Bone(name);
    bone.parent = _getString(data, "parent", "");
    bone.length = _getInt(data, "length", 0);
    _setTransform(data, bone.transform);
    return bone;
  }

  static Slot _parseSlot(Map data) {
    var name = _getString(data, "name", "");
    var slot = new Slot(name);
    slot.parent = _getString(data, "parent", null);
    slot.z = _getInt(data, "z", 0);
    return slot;
  }

  static Skin _parseSkin(Map data) {
    var name = _getString(data, "name", "");
    var skin = new Skin(name);
    skin.slots.addAll(data["slot"].map(_parseSkinSlot));
    return skin;
  }

  static SkinSlot _parseSkinSlot(Map data) {
    var name = _getString(data, "name", "");
    var skinSlot = new SkinSlot(name);
    skinSlot.displays.addAll(data["display"].map(_parseDisplay));
    return skinSlot;
  }

  static Display _parseDisplay(Map data) {
    var name = _getString(data, "name", "");
    var type = _getString(data, "type", "");
    Display display = null;
    if (type == "image") {
      display = new DisplayImage(name);
    } else if (type == "armature") {
      display = new DisplayArmature(name);
    } else {
      throw new StateError("Unsupported display type");
    }
    _setTransform(data, display.transform);
    return display;
  }

  //---------------------------------------------------------------------------

  static Animation _parseAnimation(Map data) {
    var name = _getString(data, "name", "");
    var animation = new Animation(name);
    animation.duration = _getInt(data, "duration", 0);
    animation.playTimes = _getInt(data, "playTimes", 0);
    animation.bones.addAll(data["bone"].map(_parseAnimationBone));
    animation.slots.addAll(data["slot"].map(_parseAnimationSlot));
    return animation;
  }

  static AnimationBone _parseAnimationBone(Map data) {
    var name = _getString(data, "name", "");
    var animationBone = new AnimationBone(name);
    //animationBone.scale = _getDouble(data, "scale", 1.0);
    //animationBone.offset = _getDouble(data, "offset", 0.0);
    //animationBone.pivot.x = _getDouble(data, "pX", 0.0);
    //animationBone.pivot.y = _getDouble(data, "pY", 0.0);
    animationBone.frames.addAll(data["frame"].map(_parseAnimationBoneFrame));
    return animationBone;
  }

  static AnimationSlot _parseAnimationSlot(Map data) {
    var name = _getString(data, "name", "");
    var animationSlot = new AnimationSlot(name);
    //animationSlot.visible = !_getBool(data, "hide", false);
    //animationSlot.scale = _getDouble(data, "scale", 1.0);
    //animationSlot.offset = _getDouble(data, "offset", 0.0);
    animationSlot.frames.addAll(data["frame"].map(_parseAnimationSlotFrame));
    return animationSlot;
  }

  static AnimationBoneFrame _parseAnimationBoneFrame(Map data) {
    var animationBoneFrame = new AnimationBoneFrame();
    animationBoneFrame.tweenEasing = _getIntNull(data, "tweenEasing", 10);
    animationBoneFrame.duration = _getInt(data, "duration", 0);
    _setTransform(data, animationBoneFrame.transform);
    return animationBoneFrame;
  }

  static AnimationSlotFrame _parseAnimationSlotFrame(Map data) {
    var animationSlotFrame = new AnimationSlotFrame();
    animationSlotFrame.tweenEasing = _getIntNull(data, "tweenEasing", 10);
    animationSlotFrame.duration = _getInt(data, "duration", 0);
    _setColorTransform(data, animationSlotFrame.colorTransform);
    return animationSlotFrame;
  }

  //---------------------------------------------------------------------------

  static void _setTransform(Map data, Transform transform) {
    if (data.containsKey("transform")) {
      Map value = data["transform"];
      transform.x = _getDouble(value, "x", 0.0);
      transform.y = _getDouble(value, "y", 0.0);
      transform.skewX = _getDouble(value, "skX", 0.0) * math.PI / 180.0;
      transform.skewY = _getDouble(value, "skY", 0.0) * math.PI / 180.0;
      transform.scaleX = _getDouble(value, "scX", 1.0);
      transform.scaleY = _getDouble(value, "scY", 1.0);
    }
  }

  static void _setColorTransform(Map data, ColorTransform colorTransform) {
    if (data.containsKey("color")) {
      Map value = data["color"];
      colorTransform.alphaOffset = _getInt(value, "aO", 0);
      colorTransform.redOffset = _getInt(value, "rO", 0);
      colorTransform.greenOffset = _getInt(value, "gO", 0);
      colorTransform.blueOffset = _getInt(value, "bO", 0);
      colorTransform.alphaMultiplier = _getInt(value, "aM", 100) * 0.01;
      colorTransform.redMultiplier = _getInt(value, "rM", 100) * 0.01;
      colorTransform.greenMultiplier = _getInt(value, "gM", 100) * 0.01;
      colorTransform.blueMultiplier = _getInt(value, "bM", 100) * 0.01;
    }
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

  static int _getIntNull(Map data, String key, int defaultValue) {
    var value = data.containsKey(key) ? data[key] : defaultValue;
    if (value is int) return value;
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


