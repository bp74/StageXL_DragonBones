part of stagexl_dragonbones;

class SkeletonSlot {

  final Slot slot;
  final SkeletonBone parent;
  final Matrix worldMatrix = new Matrix.fromIdentity();
  final List<SkeletonSlotDisplay> displays = new List<SkeletonSlotDisplay>();

  final ColorTransform _colorTransform;
  final List<SkeletonSlotAnimation> _skeletonSlotAnimations;

  SkeletonSlot(this.slot, this.parent)
      : _colorTransform = new ColorTransform(),
        _skeletonSlotAnimations = new List<SkeletonSlotAnimation>();

  //---------------------------------------------------------------------------

  void addSkeletonSlotAnimation(SkeletonSlotAnimation skeletonSlotAnimation) {
    _skeletonSlotAnimations.clear();
    _skeletonSlotAnimations.add(skeletonSlotAnimation);
  }

  //---------------------------------------------------------------------------

  void updateWorldMatrix(double time) {

    worldMatrix.copyFrom(parent.worldMatrix);

  }

  //---------------------------------------------------------------------------

  void render(RenderState renderState) {
    displays.first.render(renderState);
  }

}
