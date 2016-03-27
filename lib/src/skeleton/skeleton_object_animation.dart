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
        var progress = (framePosition - frameOffset) / frame.duration;
        if (frame.curve is Curve) {
          _frameProgress = frame.curve.getValue(progress);
        } else if (frame.tweenEasing is num) {
          _frameProgress = _getEaseValue(progress, frame.tweenEasing);
        }
        break;
      } else {
        frameOffset = frameEnd;
      }
    }
  }

  //---------------------------------------------------------------------------

  double _getEaseValue(double value, double easing) {

    double valueEase = 1.0;

    if (easing == 10.0) { // auto tween ?
      return value;
    } else if (easing > 1.0) { // ease in out
      valueEase = 0.5 * (1.0 - math.cos(value * math.PI));
      easing -= 1.0;
    } else if (easing > 0.0) { // ease out
      valueEase = 1.0 - math.pow(1 - value, 2);
    } else if (easing < 0.0) { // ease in
      easing *= -1.0;
      valueEase = math.pow(value, 2.0);
    }

    return (valueEase - value) * easing + value;
  }


}