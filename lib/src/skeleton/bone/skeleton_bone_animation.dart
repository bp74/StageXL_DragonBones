part of stagexl_dragonbones;

class SkeletonBoneAnimation extends SkeletonObjectAnimation {

  final Transform _transform = Transform();

  SkeletonBoneAnimation(Animation animation, BoneAnimation boneAnimation)
      : super(animation, boneAnimation);

  //---------------------------------------------------------------------------

  void update(SkeletonBone skeletonBone) {

    if (_frameIndex != null) {

      var frames = animationObject.frames;
      var progress = _frameProgress;
      var index0 = _frameIndex;
      var index1 = index0 + 1 < frames.length ? index0 + 1 : index0;

      BoneAnimationFrame frame0 = frames[index0];
      BoneAnimationFrame frame1 = frames[index1];
      Transform transform0 = frame0.transform;
      Transform transform1 = frame1.transform;

      _transform.interpolate(transform0, transform1, progress);
      skeletonBone.transform.concat(_transform);
    }
  }

}
