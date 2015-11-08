part of stagexl_dragonbones;

class Skeleton extends InteractiveObject {

  final Armature armature;
  final TextureAtlas textureAtlas;

  final List<SkeletonBone> _bones = new List<SkeletonBone>();
  final List<SkeletonSlot> _slots = new List<SkeletonSlot>();

  Skeleton(this.armature, this.textureAtlas) {

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
    // TODO implement render
  }

  //---------------------------------------------------------------------------

}

