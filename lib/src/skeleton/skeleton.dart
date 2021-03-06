part of stagexl_dragonbones;

class Skeleton extends InteractiveObject implements Animatable {
  final Armature armature;

  final List<SkeletonBone> _skeletonBones = <SkeletonBone>[];
  final List<SkeletonSlot> _skeletonSlots = <SkeletonSlot>[];

  int frameRate = 24;
  bool showBones = false;
  bool showSlots = true;

  Skin _skin;

  //---------------------------------------------------------------------------

  Skeleton(this.armature, this.frameRate) {
    var map = <String, SkeletonBone>{};

    // this assumes that armature bones are sorted by depth
    // otherwise the parents of the skeletonBones are wrong.

    for (var bone in armature.bones) {
      var parent = map.containsKey(bone.parent) ? map[bone.parent] : null;
      var skeletonBone = SkeletonBone(bone, parent);
      map[bone.name] = skeletonBone;
      _skeletonBones.add(skeletonBone);
    }

    for (var slot in armature.slots) {
      var parent = map.containsKey(slot.parent) ? map[slot.parent] : null;
      var skeletonSlot = SkeletonSlot(slot, parent);
      _skeletonSlots.add(skeletonSlot);
    }
  }

  //---------------------------------------------------------------------------

  @override
  bool advanceTime(num deltaTime) {
    var deltaFrameTime = deltaTime.toDouble() * frameRate;

    for (var skeletonBone in _skeletonBones) {
      skeletonBone.advanceFrameTime(deltaFrameTime);
    }

    for (var skeletonSlot in _skeletonSlots) {
      skeletonSlot.advanceFrameTime(deltaFrameTime);
    }

    return true;
  }

  //---------------------------------------------------------------------------

  void setSkin(TextureAtlas textureAtlas, [String skinName = '']) {
    var skin = armature.getSkin(skinName);
    if (skin == null) throw ArgumentError('skinName');

    _skin = skin;

    for (var skeletonSlot in _skeletonSlots) {
      skeletonSlot.displays.clear();
      var skinSlot = skin.getSkinSlot(skeletonSlot.slot.name);
      if (skinSlot == null) continue;
      for (var display in skinSlot.displays) {
        if (display.type == 'image') {
          var bitmapData = textureAtlas.getBitmapData(display.name);
          var renderTextureQuad = bitmapData.renderTextureQuad;
          var sd = SkeletonDisplayImage(display, renderTextureQuad);
          skeletonSlot.displays.add(sd);
        } else if (display.type == 'mesh') {
          var bitmapData = textureAtlas.getBitmapData(display.name);
          var renderTextureQuad = bitmapData.renderTextureQuad;
          var sd = SkeletonDisplayMesh(display, renderTextureQuad);
          skeletonSlot.displays.add(sd);
        } else if (display.type == 'armature') {
          var sd = SkeletonDisplayArmature(display);
          skeletonSlot.displays.add(sd);
        }
      }
    }
  }

  //---------------------------------------------------------------------------

  void play(String animationName) {
    var animation = armature.getAnimation(animationName);
    if (animation == null) throw ArgumentError('animationName');

    for (var skeletonBone in _skeletonBones) {
      var boneName = skeletonBone.bone.name;
      var boneAnimation = animation.getBoneAnimation(boneName);
      if (boneAnimation == null) continue;
      var sa = SkeletonBoneAnimation(animation, boneAnimation);
      skeletonBone.addSkeletonBoneAnimation(sa);
    }

    for (var skeletonSlot in _skeletonSlots) {
      var slotName = skeletonSlot.slot.name;
      var slotAnimation = animation.getSlotAnimation(slotName);
      if (slotAnimation == null) continue;
      var sa = SkeletonSlotAnimation(animation, slotAnimation);
      skeletonSlot.addSkeletonSlotAnimation(sa);
    }

    for (var skeletonSlot in _skeletonSlots) {
      var slotName = skeletonSlot.slot.name;
      var skinName = _skin?.name;
      var meshAnimation = animation.getMeshAnimation(slotName, skinName);
      if (meshAnimation == null) continue;
      var sa = SkeletonDisplayMeshAnimation(animation, meshAnimation);
      skeletonSlot.addSkeletonMeshAnimation(sa);
    }
  }

  //---------------------------------------------------------------------------

  @override
  Rectangle<num> get bounds {
    // implement bounds
    return Rectangle<num>(0.0, 0.0, 0.0, 0.0);
  }

  @override
  DisplayObject hitTestInput(num localX, num localY) {
    // implement hitTestInput
    return null;
  }

  @override
  void render(RenderState renderState) {
    // implement  colorTransform for slots

    if (showSlots) {
      for (var skeletonSlot in _skeletonSlots) {
        var display = skeletonSlot.display;
        if (display != null) {
          var worldMatrix = skeletonSlot.worldMatrix;
          var blendMode = skeletonSlot.blendMode;
          // var colorTransform = skeletonSlot.colorTransform;
          var alpha = skeletonSlot.colorTransform.alphaMultiplier;
          renderState.push(worldMatrix, alpha, blendMode);
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
