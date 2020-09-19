part of stagexl_dragonbones;

class SkeletonSlot extends SkeletonObject {
  final Slot slot;
  final SkeletonBone parent;
  final Matrix worldMatrix = Matrix.fromIdentity();
  final List<SkeletonDisplay> displays = <SkeletonDisplay>[];
  final List<SkeletonSlotAnimation> _slotAnimations;
  final List<SkeletonDisplayMeshAnimation> _meshAnimations;

  ColorTransform colorTransform = ColorTransform();
  BlendMode blendMode = BlendMode.NORMAL;
  SkeletonDisplay display;
  int displayIndex = 0;

  SkeletonSlot(this.slot, this.parent)
      : _slotAnimations = <SkeletonSlotAnimation>[],
        _meshAnimations = <SkeletonDisplayMeshAnimation>[];

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
    displayIndex = slot.displayIndex;

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
    if (displayMesh is SkeletonDisplayMesh && _meshAnimations.isNotEmpty) {
      displayMesh.resetVertices();
      for (var animation in _meshAnimations) {
        animation.advanceFrameTime(deltaFrameTime);
        animation.update(displayMesh);
      }
    }
  }
}
