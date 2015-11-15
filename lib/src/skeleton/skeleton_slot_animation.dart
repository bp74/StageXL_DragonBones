part of stagexl_dragonbones;

class SkeletonSlotAnimation {

  final Animation animation;
  final AnimationSlot animationSlot;
  final ColorTransform colorTransform = new ColorTransform();

  double frameTime = 0.0;

  SkeletonSlotAnimation(this.animation, this.animationSlot);

  //---------------------------------------------------------------------------

  void advanceFrameTime(double deltaFrameTime) {

    frameTime += deltaFrameTime;

    // TODO: auto tween

    var frames = animationSlot.frames;
    var frameRate = 24;
    var framePosition = frameTime % animation.duration;
    var frameOffset = 0.0;

    for(int i = 0; i < frames.length - 1; i++) {

      var frame0 = frames[i + 0];
      var frame1 = frames[i + 1];
      var frameDuration = frame0.duration;
      var frameEnd = frameOffset + frameDuration;

      if (framePosition >= frameOffset && framePosition < frameEnd) {
        var progress = (framePosition - frameOffset) / frameDuration;
        var tweenEasing = frame0.tweenEasing;
        var transform0 = frame0.colorTransform;
        var transform1 = frame1.colorTransform;
        if (tweenEasing is! num) { // no tween
          colorTransform.copyFrom(transform0);
        } else if (tweenEasing == 10.0) { // auto tween ?
          colorTransform.interpolate(transform0, transform1, progress);
        } else { // ease in, linear, ease out, ease in out
          var easeValue = _getEaseValue(progress, tweenEasing);
          colorTransform.interpolate(transform0, transform1, easeValue);
        }
        return;
      } else {
        frameOffset = frameEnd;
      }
    }

    colorTransform.reset();
  }

}
