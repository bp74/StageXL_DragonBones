part of stagexl_dragonbones;

class SkeletonSlot {

  final Slot slot;
  final SkeletonBone parent;
  final Matrix worldMatrix = new Matrix.fromIdentity();
  final List<SkeletonSlotDisplay> displays = new List<SkeletonSlotDisplay>();
  final List<SkeletonSlotAnimation> _skeletonSlotAnimations;

  ColorTransform colorTransform = new ColorTransform();
  BlendMode blendMode = BlendMode.NORMAL;
  SkeletonSlotDisplay display = null;
  int displayIndex = 0;

  SkeletonSlot(this.slot, this.parent)
      : _skeletonSlotAnimations = new List<SkeletonSlotAnimation>();

  //---------------------------------------------------------------------------

  void addSkeletonSlotAnimation(SkeletonSlotAnimation skeletonSlotAnimation) {
    _skeletonSlotAnimations.clear();
    _skeletonSlotAnimations.add(skeletonSlotAnimation);
  }

  //---------------------------------------------------------------------------

  void advanceFrameTime(double deltaFrameTime) {

    colorTransform.reset();

    for (var skeletonSlotAnimation in _skeletonSlotAnimations) {
      skeletonSlotAnimation.advanceFrameTime(deltaFrameTime);
      colorTransform.concat(skeletonSlotAnimation.colorTransform);
      displayIndex = skeletonSlotAnimation.displayIndex;
    }

    if (displayIndex >= 0 && displayIndex < displays.length) {
      display = displays[displayIndex];
      worldMatrix.copyFromAndConcat(display.matrix, parent.worldMatrix);
    } else {
      display = null;
      worldMatrix.copyFrom(parent.worldMatrix);
    }
  }

}
