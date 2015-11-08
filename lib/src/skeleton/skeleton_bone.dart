part of stagexl_dragonbones;

class SkeletonBone {

  final Bone bone;
  final SkeletonBone parent;
  final Matrix worldMatrix = new Matrix.fromIdentity();

  final Transform _transform = new Transform();
  final List<SkeletonBoneAnimation> _skeletonBoneAnimations;

  SkeletonBone(this.bone, this.parent)
      : _skeletonBoneAnimations = new List<SkeletonBoneAnimation>();


  //---------------------------------------------------------------------------

  void addSkeletonBoneAnimation(SkeletonBoneAnimation skeletonBoneAnimation) {
    _skeletonBoneAnimations.clear();
    _skeletonBoneAnimations.add(skeletonBoneAnimation);
  }

  //---------------------------------------------------------------------------

  void updateWorldMatrix(double time) {

    _transform.copyFrom(this.bone.transform);

    for (var skeletonBoneAnimation in _skeletonBoneAnimations) {
      skeletonBoneAnimation.updateTransform(time);
      _transform.append(skeletonBoneAnimation.transform);
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
