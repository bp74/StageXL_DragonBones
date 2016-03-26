part of stagexl_dragonbones;

class SkeletonMeshAnimation {

  final Animation animation;
  final MeshAnimation meshAnimation;

  double frameTime = 0.0;

  int _frameIndex;
  num _frameEasing;

  SkeletonMeshAnimation(this.animation, this.meshAnimation);

  //---------------------------------------------------------------------------

  void advanceFrameTime(double deltaFrameTime) {

    frameTime += deltaFrameTime;

    var frames = meshAnimation.frames;
    var framePosition = frameTime % animation.duration;
    var frameOffset = 0.0;
    var frameIndex = -1;

    for (var i = 0; i < frames.length && frameIndex == -1; i++) {
      var frame = frames[i];
      var frameEnd = frameOffset + frame.duration;
      if (framePosition >= frameOffset && framePosition < frameEnd) {
        frameIndex = i;
      } else {
        frameOffset = frameEnd;
      }
    }

    if (frameIndex < 0) {
      _frameIndex = null;
      _frameEasing = null;
    } else if (frameIndex < frames.length - 1) {
      _frameIndex = frameIndex;
      var frame = frames[frameIndex];
      var progress = (framePosition - frameOffset) / frame.duration;
      var tweenEasing = frame.tweenEasing;
      var tweenCurve = frame.curve;
      if (tweenCurve is Curve) {
        _frameEasing = tweenCurve.getValue(progress);
      } else if (tweenEasing is! num) { // no tween
        _frameEasing = 0.0;
      } else if (tweenEasing == 10.0) { // auto tween ?
        _frameEasing = progress;
      } else if (tweenEasing is num) { // ease in, ease out, ease in out
        _frameEasing = _getEaseValue(progress, tweenEasing);
      } else {
        _frameEasing = 0.0;
      }
    }
  }

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

      var frames = meshAnimation.frames;

      var index0 = _frameIndex;
      var weight0 = 1.0 - _frameEasing;
      var offset0 = frames[index0].offset;
      var vertices0 = frames[index0].vertices;

      var index1 = index0 + 1 < frames.length ? index0 + 1 : index0;
      var weight1 = 0.0 + _frameEasing;
      var offset1 = frames[index1].offset;
      var vertices1 = frames[index1].vertices;

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