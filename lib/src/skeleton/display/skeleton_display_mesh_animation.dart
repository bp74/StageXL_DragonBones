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

      MeshAnimationFrame frame0 = frames[index0];
      MeshAnimationFrame frame1 = frames[index1];
      Float32List vxList = displayMesh.vxList;

      var offset = frame0.offset;
      var vertices = frame0.vertices;

      for (int i = 0, o = offset * 2; i < vertices.length - 1; i += 2, o += 4) {
        vxList[o + 0] += vertices[i + 0] * (1.0 - progress);
        vxList[o + 1] += vertices[i + 1] * (1.0 - progress);
      }

      offset = frame1.offset;
      vertices = frame1.vertices;

      for (int i = 0, o = offset * 2; i < vertices.length - 1; i += 2, o += 4) {
        vxList[o + 0] += vertices[i + 0] * progress;
        vxList[o + 1] += vertices[i + 1] * progress;
      }
    }
  }

}