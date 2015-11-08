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

    var oldTime = _time;
    var newTime = _time + deltaTime;

    for (var skeletonBone in _skeletonBones) {
      skeletonBone.updateWorldMatrix(newTime);
    }

    _time = newTime;
    return true;
  }

  //---------------------------------------------------------------------------

  void play(String animationName) {

    var animation = this.armature.getAnimation(animationName);
    if (animation == null) throw new ArgumentError("animationName");

    for(var skeletonBone in _skeletonBones) {
      var boneName = skeletonBone.bone.name;
      var animationBone = animation.getAnimationBone(boneName);
      var sba = new SkeletonBoneAnimation(animation, animationBone);
      skeletonBone.addSkeletonBoneAnimation(sba);
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
      newRenderState.globalMatrix.copyFrom(skeletonBone.worldMatrix);
      newRenderState.globalMatrix.concat(globalMatrix);
      var l = skeletonBone.bone.length;
      newRenderState.renderTriangle(0, 5, 0, -5, l, 0, Color.Red);
      newRenderState.renderTriangle(-3, -3, 3, -3, 3, 3, Color.Green);
      newRenderState.renderTriangle(-3, -3, 3, 3, -3, 3, Color.Green);
    }
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

}

