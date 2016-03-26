part of stagexl_dragonbones;

class SkeletonObjectAnimation {

  final Animation animation;
  final AnimationObject baseAnimation;

  int _frameIndex;
  num _frameEasing;
  num _frameTime = 0.0;

  SkeletonObjectAnimation(this.animation, this.baseAnimation);

  //---------------------------------------------------------------------------

  void advanceFrameTime(double deltaFrameTime) {

    _frameTime += deltaFrameTime;

    var frames = baseAnimation.frames;
    var framePosition = _frameTime % animation.duration;
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

}