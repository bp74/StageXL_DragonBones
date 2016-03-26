part of stagexl_dragonbones;

class SkeletonSlotAnimation extends SkeletonObjectAnimation {

  final ColorTransform _colorTransform = new ColorTransform();

  SkeletonSlotAnimation(Animation animation, SlotAnimation slotAnimation)
      : super(animation, slotAnimation);

  //---------------------------------------------------------------------------

  void update(SkeletonSlot skeletonSlot) {

    if (_frameIndex != null) {

      var frames = animationObject.frames;
      var progress = _frameProgress;
      var index0 = _frameIndex;
      var index1 = index0 + 1 < frames.length ? index0 + 1 : index0;

      SlotAnimationFrame frame0 = frames[index0];
      SlotAnimationFrame frame1 = frames[index1];
      ColorTransform transform0 = frame0.colorTransform;
      ColorTransform transform1 = frame1.colorTransform;

      _colorTransform.interpolate(transform0, transform1, progress);
      skeletonSlot.colorTransform.concat(_colorTransform);
      skeletonSlot.displayIndex = frame0.displayIndex;
    }
  }

}
