part of stagexl_dragonbones;

class SkeletonSlot {

  final Slot slot;
  final SkeletonBone parent;
  final Matrix worldMatrix = new Matrix.fromIdentity();
  final List<SkeletonDisplay> displays = new List<SkeletonDisplay>();
  final List<SkeletonSlotAnimation> _slotAnimations;
  final List<SkeletonMeshAnimation> _meshAnimations;

  ColorTransform colorTransform = new ColorTransform();
  BlendMode blendMode = BlendMode.NORMAL;
  SkeletonDisplay display = null;
  int displayIndex = 0;

  SkeletonSlot(this.slot, this.parent)
      : _slotAnimations = new List<SkeletonSlotAnimation>(),
        _meshAnimations = new List<SkeletonMeshAnimation>();

  //---------------------------------------------------------------------------

  void addSkeletonAnimationSlot(SkeletonSlotAnimation animation) {
    _slotAnimations.clear();
    _slotAnimations.add(animation);
  }

  void addSkeletonAnimationMesh(SkeletonMeshAnimation animation) {
    _meshAnimations.clear();
    _meshAnimations.add(animation);
  }

  //---------------------------------------------------------------------------

  void advanceFrameTime(double deltaFrameTime) {

    colorTransform.reset();

    for (var animation in _slotAnimations) {
      animation.advanceFrameTime(deltaFrameTime);
      colorTransform.concat(animation.colorTransform);
      displayIndex = animation.displayIndex;
    }

    if (displayIndex >= 0 && displayIndex < displays.length) {
      display = displays[displayIndex];
      worldMatrix.copyFromAndConcat(display.matrix, parent.worldMatrix);
    } else {
      display = null;
      worldMatrix.copyFrom(parent.worldMatrix);
    }

    for (var animation in _meshAnimations) {
      animation.advanceFrameTime(deltaFrameTime);
      var displayMesh = display;
      if (displayMesh is SkeletonDisplayMesh) {
        animation.update(displayMesh);
      }
    }

  }

}
