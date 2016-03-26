part of stagexl_dragonbones;

class SkeletonSlot extends SkeletonObject {

  final Slot slot;
  final SkeletonBone parent;
  final Matrix worldMatrix = new Matrix.fromIdentity();
  final List<SkeletonDisplay> displays = new List<SkeletonDisplay>();
  final List<SkeletonSlotAnimation> _slotAnimations;
  final List<SkeletonDisplayMeshAnimation> _meshAnimations;

  ColorTransform colorTransform = new ColorTransform();
  BlendMode blendMode = BlendMode.NORMAL;
  SkeletonDisplay display = null;
  int displayIndex = 0;

  SkeletonSlot(this.slot, this.parent)
      : _slotAnimations = new List<SkeletonSlotAnimation>(),
        _meshAnimations = new List<SkeletonDisplayMeshAnimation>();

  //---------------------------------------------------------------------------

  void addSkeletonSlotAnimation(SkeletonSlotAnimation animation) {
    _slotAnimations.clear();
    _slotAnimations.add(animation);
  }

  void addSkeletonMeshAnimation(SkeletonDisplayMeshAnimation animation) {
    _meshAnimations.clear();
    _meshAnimations.add(animation);
  }

  //---------------------------------------------------------------------------

  void advanceFrameTime(double deltaFrameTime) {

    colorTransform.reset();

    for (var animation in _slotAnimations) {
      animation.advanceFrameTime(deltaFrameTime);
      animation.update(this);
    }

    if (displayIndex >= 0 && displayIndex < displays.length) {
      display = displays[displayIndex];
      worldMatrix.copyFromAndConcat(display.matrix, parent.worldMatrix);
    } else {
      display = null;
      worldMatrix.copyFrom(parent.worldMatrix);
    }

    var displayMesh = display;
    if (displayMesh is SkeletonDisplayMesh && _meshAnimations.length > 0) {
      displayMesh.resetVertices();
      for (var animation in _meshAnimations) {
        animation.advanceFrameTime(deltaFrameTime);
        animation.update(displayMesh);
      }
    }

  }

}
