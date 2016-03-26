part of stagexl_dragonbones;

class SkeletonBoneAnimation extends SkeletonObjectAnimation {

  final Transform _transform = new Transform();

  SkeletonBoneAnimation(Animation animation, BoneAnimation boneAnimation)
      : super(animation, boneAnimation);

  //---------------------------------------------------------------------------

  void update(Transform boneTransform) {

    if (_frameIndex != null) {

      var frames = baseAnimation.frames;

      var index0 = _frameIndex;
      var frame0 = frames[index0];
      var transform0 = frame0.transform;

      var index1 = index0 + 1 < frames.length ? index0 + 1 : index0;
      var frame1 = frames[index1];
      var transform1 = frame1.transform;

      _transform.interpolate(transform0, transform1, _frameEasing);
      boneTransform.concat(_transform);
    }

  }

}
