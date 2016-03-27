part of stagexl_dragonbones;

class SkeletonDisplayMeshAnimation extends SkeletonObjectAnimation {

  SkeletonDisplayMeshAnimation(Animation animation, MeshAnimation meshAnimation)
      : super(animation, meshAnimation);

  //---------------------------------------------------------------------------

  void update(SkeletonDisplayMesh displayMesh) {

    if (_frameIndex != null) {

      var frames = animationObject.frames;
      var progress = _frameProgress;
      var index0 = _frameIndex;
      var index1 = index0 + 1 < frames.length ? index0 + 1 : index0;

      Float32List vxList = displayMesh.vxList;
      MeshAnimationFrame f0 = frames[index0];
      MeshAnimationFrame f1 = frames[index1];
      Float32List v0 = f0.vertices;
      Float32List v1 = f1.vertices;
      double p0 = (1.0 - progress);
      double p1 = (0.0 + progress);

      for (int i = 0, o = f0.offset * 2; i < v0.length - 1; i += 2, o += 4) {
        vxList[o + 0] += v0[i + 0] * p0;
        vxList[o + 1] += v0[i + 1] * p0;
      }

      for (int i = 0, o = f1.offset * 2; i < v1.length - 1; i += 2, o += 4) {
        vxList[o + 0] += v1[i + 0] * p1;
        vxList[o + 1] += v1[i + 1] * p1;
      }
    }
  }

}