part of stagexl_dragonbones;

class Skeleton extends InteractiveObject {

  final Armature armature;
  final TextureAtlas textureAtlas;

  final List<SkeletonBone> _skeletonBones = new List<SkeletonBone>();
  final List<SkeletonSlot> _skeletonSlots = new List<SkeletonSlot>();

  Skeleton(this.armature, this.textureAtlas) {
    _buildSkeletonBones();
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

    for (var skeletonBone in skeletonBones) {
      skeletonBone._updateWorldMatrix();
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
    }
  }

  //---------------------------------------------------------------------------

}

