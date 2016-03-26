part of stagexl_dragonbones;

class SkeletonMeshAnimation extends SkeletonObjectAnimation {

  SkeletonMeshAnimation(Animation animation, MeshAnimation meshAnimation)
      : super(animation, meshAnimation);

  //---------------------------------------------------------------------------

  void update(SkeletonDisplayMesh displayMesh) {

    Mesh mesh = displayMesh.display;
    Float32List vxList = displayMesh.vxList;
    Float32List vertices = mesh.vertices;

    if (_frameIndex == null) {

      for (int i = 0, o = 0; i < vertices.length - 1; i += 2, o += 4) {
        vxList[o + 0] = vertices[i + 0];
        vxList[o + 1] = vertices[i + 1];
      }

    } else {

      var frames = baseAnimation.frames;

      var index0 = _frameIndex;
      var weight0 = 1.0 - _frameEasing;
      var frame0 = frames[index0];
      var offset0 = frame0.offset;
      var vertices0 = frame0.vertices;

      var index1 = index0 + 1 < frames.length ? index0 + 1 : index0;
      var weight1 = 0.0 + _frameEasing;
      var frame1 = frames[index1];
      var offset1 = frame1.offset;
      var vertices1 = frame1.vertices;

      for (int i = 0, o = 0; i < vertices.length - 1; i += 2, o += 4) {
        num x = vertices[i + 0];
        num y = vertices[i + 1];
        if (i >= offset0 && i < offset0 + vertices0.length - 1) {
          x += vertices0[i - offset0 + 0] * weight0;
          y += vertices0[i - offset0 + 1] * weight0;
        }
        if (i >= offset1 && i < offset1 + vertices1.length - 1) {
          x += vertices1[i - offset1 + 0] * weight1;
          y += vertices1[i - offset1 + 1] * weight1;
        }
        vxList[o + 0] = x;
        vxList[o + 1] = y;
      }
    }

  }

}