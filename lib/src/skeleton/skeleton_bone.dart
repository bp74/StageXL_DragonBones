part of stagexl_dragonbones;

class SkeletonBone {

  final Bone bone;
  final SkeletonBone parent;
  final Matrix worldMatrix = new Matrix.fromIdentity();

  final Transform _transform;
  final List<SkeletonBoneAnimation> _skeletonBoneAnimations;

  SkeletonBone(this.bone, this.parent)
      : _transform = new Transform(),
        _skeletonBoneAnimations = new List<SkeletonBoneAnimation>();

  //---------------------------------------------------------------------------

  void addSkeletonBoneAnimation(SkeletonBoneAnimation skeletonBoneAnimation) {
    _skeletonBoneAnimations.clear();
    _skeletonBoneAnimations.add(skeletonBoneAnimation);
  }

  //---------------------------------------------------------------------------

  void advanceTime(double deltaTime) {

    _transform.copyFrom(bone.transform);

    for (var skeletonBoneAnimation in _skeletonBoneAnimations) {
      skeletonBoneAnimation.advanceTime(deltaTime);
      _transform.concat(skeletonBoneAnimation.transform);
    }

    if (parent != null) {
      var transformMatrix = _transform.matrix;
      var parentMatrix = parent.worldMatrix;
      worldMatrix.copyFromAndConcat(transformMatrix, parentMatrix);
    } else {
      var transformMatrix = _transform.matrix;
      worldMatrix.copyFrom(transformMatrix);
    }
  }

}
