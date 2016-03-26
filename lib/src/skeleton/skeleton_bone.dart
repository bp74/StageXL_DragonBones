part of stagexl_dragonbones;

class SkeletonBone {

  final Bone bone;
  final SkeletonBone parent;
  final Matrix worldMatrix = new Matrix.fromIdentity();

  final Transform _transform;
  final List<SkeletonBoneAnimation> _boneAnimations;

  SkeletonBone(this.bone, this.parent)
      : _transform = new Transform(),
        _boneAnimations = new List<SkeletonBoneAnimation>();

  //---------------------------------------------------------------------------

  void addSkeletonAnimationBone(SkeletonBoneAnimation animation) {
    _boneAnimations.clear();
    _boneAnimations.add(animation);
  }

  //---------------------------------------------------------------------------

  void advanceFrameTime(double deltaFrameTime) {

    _transform.copyFrom(bone.transform);

    for (var animation in _boneAnimations) {
      animation.advanceFrameTime(deltaFrameTime);
      _transform.concat(animation.transform);
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
