part of stagexl_dragonbones;

class SkeletonObjectAnimation {

  final Animation animation;
  final AnimationObject animationObject;

  num _frameTime = 0.0;
  num _frameProgress = 0.0;
  int _frameIndex;

  SkeletonObjectAnimation(this.animation, this.animationObject);

  //---------------------------------------------------------------------------

  void advanceFrameTime(double deltaFrameTime) {

    _frameTime += deltaFrameTime;
    _frameProgress = 0.0;
    _frameIndex = null;

    var frames = animationObject.frames;
    var framePosition = _frameTime % animation.duration;
    var frameOffset = 0.0;

    for (var i = 0; i < frames.length; i++) {
      var frameEnd = frameOffset + frames[i].duration;
      if (framePosition >= frameOffset && framePosition < frameEnd) {
        _frameIndex = i;
        _frameProgress = 0.0;
        var frame = frames[i];
        var frameDuration = frame.duration;
        var progress = (framePosition - frameOffset) / frameDuration;
        var tweenEasing = frame.tweenEasing;
        var tweenCurve = frame.curve;
        if (tweenCurve is Curve) {
          _frameProgress = tweenCurve.getValue(progress);
        } else if (tweenEasing == 10.0) { // auto tween ?
          _frameProgress = progress;
        } else if (tweenEasing is num) { // ease in, ease out, ease in out
          _frameProgress = _getEaseValue(progress, tweenEasing);
        }
        break;
      } else {
        frameOffset = frameEnd;
      }
    }
  }

}