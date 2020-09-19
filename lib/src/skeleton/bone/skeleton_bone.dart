part of stagexl_dragonbones;

class SkeletonBone extends SkeletonObject {
  final Bone bone;
  final SkeletonBone parent;
  final Matrix worldMatrix = Matrix.fromIdentity();
  final List<SkeletonBoneAnimation> _boneAnimations;

  final Transform transform = Transform();

  SkeletonBone(this.bone, this.parent)
      : _boneAnimations = <SkeletonBoneAnimation>[];

  //---------------------------------------------------------------------------

  void addSkeletonBoneAnimation(SkeletonBoneAnimation animation) {
    _boneAnimations.clear();
    _boneAnimations.add(animation);
  }

  //---------------------------------------------------------------------------

  void advanceFrameTime(double deltaFrameTime) {
    transform.copyFrom(bone.transform);

    for (var animation in _boneAnimations) {
      animation.advanceFrameTime(deltaFrameTime);
      animation.update(this);
    }

    if (parent != null) {
      var transformMatrix = transform.matrix;
      var parentMatrix = parent.worldMatrix;
      worldMatrix.copyFromAndConcat(transformMatrix, parentMatrix);
    } else {
      var transformMatrix = transform.matrix;
      worldMatrix.copyFrom(transformMatrix);
    }
  }
}
