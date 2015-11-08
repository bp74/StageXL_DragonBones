part of stagexl_dragonbones;

class SkeletonBone {

  final Bone bone;
  final SkeletonBone parent;

  final Matrix _matrix = new Matrix.fromIdentity();
  final Matrix _worldMatrix = new Matrix.fromIdentity();

  SkeletonBone(this.bone, this.parent) {
    _matrix.copyFrom(this.bone.transform.matrix);
  }

  //---------------------------------------------------------------------------

  void _updateWorldMatrix() {

    _worldMatrix.copyFrom(_matrix);

    if (parent != null) {
      _worldMatrix.concat(parent._worldMatrix);
    }
  }



}
