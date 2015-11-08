part of stagexl_dragonbones;

class Skeleton extends InteractiveObject implements Animatable {

  final Armature armature;
  final TextureAtlas textureAtlas;

  final List<SkeletonBone> _skeletonBones = new List<SkeletonBone>();
  final List<SkeletonSlot> _skeletonSlots = new List<SkeletonSlot>();

  double _time = 0.0;

  Skeleton(this.armature, this.textureAtlas) {
    _buildSkeletonBones();
  }

  //---------------------------------------------------------------------------

  bool advanceTime(num deltaTime) {

    // TODO: this is just a prrof of concept implementation
    // TODO: get framerate from dragon bones file
    // TODO: play custom animation

    var oldTime = _time;
    var newTime = _time + deltaTime * 0.5;
    var animation = this.armature.animations[1];
    var frameRate = 24;

    for(var skeletonBone in _skeletonBones) {

      var name = skeletonBone.bone.name;
      var animationBone = animation.bones.firstWhere((ab) => ab.name == name);
      var framePosition = (newTime * frameRate) % animation.duration;
      var frameOffset = 0.0;

      for(int i = 0; i < animationBone.frames.length - 1; i++) {
        var animationBoneFrame1 = animationBone.frames[i + 0];
        var animationBoneFrame2 = animationBone.frames[i + 1];
        var frameEnd = frameOffset + animationBoneFrame1.duration;
        if (framePosition >= frameOffset && framePosition < frameEnd) {
          var duration = animationBoneFrame1.duration;
          var tweenEasing = animationBoneFrame1.tweenEasing;
          var transform1 = animationBoneFrame1.transform;
          var transform2 = animationBoneFrame2.transform;
          var progress = (framePosition - frameOffset) / duration;
          var easeValue = _getEaseValue(progress, tweenEasing ?? 0.0);
          skeletonBone._updateWorldMatrix(transform1, transform2, easeValue);
        }
        frameOffset += animationBoneFrame1.duration;
      }
    }

    _time = newTime;
    return true;
  }

  //---------------------------------------------------------------------------

  void _buildSkeletonBones() {

    var map = new Map<String, SkeletonBone>();
    var skeletonBones = _skeletonBones;

    // this assumes that armature bones are sorted by depth
    // otherwise the parents of the skeletonBones are wrong.

    for (var bone in this.armature.bones) {
      var parent = map.containsKey(bone.parent) ? map[bone.parent] : null;
      var skeletonBone = new SkeletonBone(bone, parent);
      map[bone.name] = skeletonBone;
      skeletonBones.add(skeletonBone);
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

    // DEBUG RENDERING
    var renderContext = renderState.renderContext;
    var globalMatrix = renderState.globalMatrix;
    var newRenderState = new RenderState(renderContext);

    for(var skeletonBone in _skeletonBones) {
      newRenderState.globalMatrix.copyFrom(skeletonBone._worldMatrix);
      newRenderState.globalMatrix.concat(globalMatrix);
      var l = skeletonBone.bone.length;
      newRenderState.renderTriangle(0, 5, 0, -5, l, 0, Color.Red);
      newRenderState.renderTriangle(-3, -3, 3, -3, 3, 3, Color.Green);
      newRenderState.renderTriangle(-3, -3, 3, 3, -3, 3, Color.Green);
    }
  }

  //---------------------------------------------------------------------------

}

