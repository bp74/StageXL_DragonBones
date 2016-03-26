part of stagexl_dragonbones;

class SkeletonBoneAnimation {

  final Animation animation;
  final BoneAnimation boneAnimation;
  final Transform transform = new Transform();

  double frameTime = 0.0;

  SkeletonBoneAnimation(this.animation, this.boneAnimation);

  //---------------------------------------------------------------------------

  void advanceFrameTime(double deltaFrameTime) {

    frameTime += deltaFrameTime;

    // TODO: auto tween

    var frames = boneAnimation.frames;
    var framePosition = frameTime  % animation.duration;
    var frameOffset = 0.0;

    for(int i = 0; i < frames.length - 1; i++) {

      var frame0 = frames[i + 0];
      var frame1 = frames[i + 1];
      var frameDuration = frame0.duration;
      var frameEnd = frameOffset + frameDuration;

      if (framePosition >= frameOffset && framePosition < frameEnd) {
        var progress = (framePosition - frameOffset) / frameDuration;
        var tweenEasing = frame0.tweenEasing;
        var tweenCurve = frame0.curve;
        var transform0 = frame0.transform;
        var transform1 = frame1.transform;
        if (tweenCurve is Curve) {
          var easeValue = tweenCurve.getValue(progress);
          transform.interpolate(transform0, transform1, easeValue);
        } else if (tweenEasing is! num) { // no tween
          transform.copyFrom(transform0);
        } else if (tweenEasing == 10.0) { // auto tween ?
          transform.interpolate(transform0, transform1, progress);
        } else { // ease in, linear, ease out, ease in out
          var easeValue = _getEaseValue(progress, tweenEasing);
          transform.interpolate(transform0, transform1, easeValue);
        }
        return;
      } else {
        frameOffset = frameEnd;
      }
    }

    if (frames.length == 1 && framePosition < frames.first.duration) {
      transform.copyFrom(frames.first.transform);
    } else if (frames.length == 0) {
      transform.reset();
    } else {
      transform.reset();
    }
  }


}
