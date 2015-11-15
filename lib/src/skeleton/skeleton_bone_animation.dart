part of stagexl_dragonbones;

class SkeletonBoneAnimation {

  final Animation animation;
  final AnimationBone animationBone;
  final Transform transform = new Transform();

  double time = 0.0;

  SkeletonBoneAnimation(this.animation, this.animationBone);

  //---------------------------------------------------------------------------

  void advanceTime(double deltaTime) {

    time += deltaTime;

    // TODO: framerate
    // TODO: auto tween

    var frames = animationBone.frames;
    var frameRate = 24;
    var framePosition = (time * frameRate) % animation.duration;
    var frameOffset = 0.0;

    for(int i = 0; i < frames.length - 1; i++) {

      var frame0 = frames[i + 0];
      var frame1 = frames[i + 1];
      var frameDuration = frame0.duration;
      var frameEnd = frameOffset + frameDuration;

      if (framePosition >= frameOffset && framePosition < frameEnd) {
        var progress = (framePosition - frameOffset) / frameDuration;
        var tweenEasing = frame0.tweenEasing;
        var transform0 = frame0.transform;
        var transform1 = frame1.transform;
        if (tweenEasing is! num) { // no tween
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

    transform.reset();
  }


}
