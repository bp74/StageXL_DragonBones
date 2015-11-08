part of stagexl_dragonbones;

class SkeletonBone {

  final Bone bone;
  final SkeletonBone parent;

  final Matrix _setupMatrix = new Matrix.fromIdentity();
  final Matrix _worldMatrix = new Matrix.fromIdentity();

  SkeletonBone(this.bone, this.parent) {
    _setupMatrix.copyFrom(this.bone.transform.matrix);
  }

  //---------------------------------------------------------------------------

  void _updateWorldMatrix(Transform t1, Transform t2, double value) {

    Transform t0 = this.bone.transform;

    double scaleX = t0.scaleX * (t1.scaleX + (t2.scaleX - t1.scaleX) * value);
    double scaleY = t0.scaleY * (t1.scaleY + (t2.scaleY - t1.scaleY) * value);
    double skewX = t0.skewX + t1.skewX + (t2.skewX - t1.skewX) * value;
    double skewY = t0.skewY + t1.skewY + (t2.skewY - t1.skewY) * value;

    _worldMatrix.a = 0.0 + scaleX * math.cos(skewY);
    _worldMatrix.b = 0.0 + scaleX * math.sin(skewY);
    _worldMatrix.c = 0.0 - scaleY * math.sin(skewX);
    _worldMatrix.d = 0.0 + scaleY * math.cos(skewX);
    _worldMatrix.tx = t0.x + t1.x + (t2.x - t1.x) * value;
    _worldMatrix.ty = t0.y + t1.y + (t2.y - t1.y) * value;

    // TODO: Why does the matrix not work?
    // TODO: We could precalculate bone transform + animation transforms
    //t1.tweenToMatrix(t2, value, _worldMatrix);
    //_worldMatrix.prepend(_setupMatrix);

    if (parent != null) {
      _worldMatrix.concat(parent._worldMatrix);
    }
  }



}
