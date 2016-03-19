part of stagexl_dragonbones;

class Skeleton extends InteractiveObject implements Animatable {

  final Armature armature;

  final List<SkeletonBone> _skeletonBones = new List<SkeletonBone>();
  final List<SkeletonSlot> _skeletonSlots = new List<SkeletonSlot>();

  int frameRate = 24;
  bool showBones = false;
  bool showSlots = true;
  String _skinName = null;

  //---------------------------------------------------------------------------

  Skeleton(this.armature, this.frameRate) {

    var map = new Map<String, SkeletonBone>();

    // this assumes that armature bones are sorted by depth
    // otherwise the parents of the skeletonBones are wrong.

    for (var bone in armature.bones) {
      var parent = map.containsKey(bone.parent) ? map[bone.parent] : null;
      var skeletonBone = new SkeletonBone(bone, parent);
      map[bone.name] = skeletonBone;
      _skeletonBones.add(skeletonBone);
    }

    for (var slot in armature.slots) {
      var parent = map.containsKey(slot.parent) ? map[slot.parent] : null;
      var skeletonSlot = new SkeletonSlot(slot, parent);
      _skeletonSlots.add(skeletonSlot);
    }
  }

  //---------------------------------------------------------------------------

  bool advanceTime(num deltaTime) {

    double deltaFrameTime = deltaTime.toDouble() * frameRate;

    for (var skeletonBone in _skeletonBones) {
      skeletonBone.advanceFrameTime(deltaFrameTime);
    }

    for(var skeletonSlot in _skeletonSlots) {
      skeletonSlot.advanceFrameTime(deltaFrameTime);
    }

    return true;
  }

  //---------------------------------------------------------------------------

  void setSkin(TextureAtlas textureAtlas, [String skinName = ""]) {

    var skin = this.armature.getSkin(skinName);
    if (skin == null) throw new ArgumentError("skinName");

    _skinName = skin.name;

    for (var skeletonSlot in _skeletonSlots) {

      skeletonSlot.displays.clear();

      var skinSlot = skin.getSkinSlot(skeletonSlot.slot.name);
      if (skinSlot == null) continue;

      for (var display in skinSlot.displays) {
        if (display.type == "image") {
          var bitmapData = textureAtlas.getBitmapData(display.name);
          var renderTextureQuad = bitmapData.renderTextureQuad;
          var ssd = new SkeletonSlotDisplayImage(display, renderTextureQuad);
          skeletonSlot.displays.add(ssd);
        } else if (display.type == "mesh") {
          var bitmapData = textureAtlas.getBitmapData(display.name);
          var renderTextureQuad = bitmapData.renderTextureQuad;
          var ssd = new SkeletonSlotDisplayMesh(display, renderTextureQuad);
          skeletonSlot.displays.add(ssd);
        } else if (display.type == "armature") {
          var ssd = new SkeletonSlotDisplayArmature(display);
          skeletonSlot.displays.add(ssd);
        }
      }
    }
  }

  //---------------------------------------------------------------------------

  void play(String animationName) {

    var animation = this.armature.getAnimation(animationName);
    if (animation == null) throw new ArgumentError("animationName");

    for (var skeletonBone in _skeletonBones) {
      var boneName = skeletonBone.bone.name;
      var animationBone = animation.getAnimationBone(boneName);
      if (animationBone != null) {
        var sba = new SkeletonBoneAnimation(animation, animationBone);
        skeletonBone.addSkeletonBoneAnimation(sba);
      }
    }

    for (var skeletonSlot in _skeletonSlots) {
      var slotName = skeletonSlot.slot.name;
      var animationSlot = animation.getAnimationSlot(slotName);
      if (animationSlot != null) {
        var ssa = new SkeletonSlotAnimation(animation, animationSlot);
        skeletonSlot.addSkeletonSlotAnimation(ssa);
      }
    }
  }

  //---------------------------------------------------------------------------

  @override
  Rectangle<num> get bounds {
    // TODO implement bounds
    return new Rectangle<num>(0.0, 0.0, 0.0 ,0.0);
  }

  @override
  DisplayObject hitTestInput(num localX, num localY) {
    // TODO implement hitTestInput
    return null;
  }

  @override
  void render(RenderState renderState) {

    if (showSlots) {
      for (var skeletonSlot in _skeletonSlots) {
        var display = skeletonSlot.display;
        if (display != null) {
          var worldMatrix = skeletonSlot.worldMatrix;
          //var colorTransform = skeletonSlot.colorTransform;
          var blendMode = skeletonSlot.blendMode;
          renderState.push(worldMatrix, 1.0, blendMode);
          display.render(renderState);
          renderState.pop();
        }
      }
    }

    if (showBones) {
      for (var skeletonBone in _skeletonBones) {
        var l = skeletonBone.bone.length;
        renderState.push(skeletonBone.worldMatrix, 1.0, BlendMode.NORMAL);
        renderState.renderTriangle(0, 5, 0, -5, l, 0, Color.Red);
        renderState.renderTriangle(-3, -3, 3, -3, 3, 3, Color.Green);
        renderState.renderTriangle(-3, -3, 3, 3, -3, 3, Color.Green);
        renderState.pop();
      }
    }
  }

}

