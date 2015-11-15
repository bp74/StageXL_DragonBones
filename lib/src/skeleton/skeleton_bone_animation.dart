part of stagexl_dragonbones;

class SkeletonBoneAnimation {

  final Animation animation;
  final AnimationBone animationBone;
  final Transform transform = new Transform();

  SkeletonBoneAnimation(this.animation, this.animationBone);

  //---------------------------------------------------------------------------

  void updateTransform(double time) {

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
        if (tweenEasing is! num) { // no tween
          transform.copyFrom(frame0.transform);
        } else if (tweenEasing == 10.0) { // auto tween ?
          transform.interpolate(frame0.transform, frame1.transform, progress);
        } else { // ease in, linear, ease out, ease in out
          var easeValue = _getEaseValue(progress, tweenEasing);
          transform.interpolate(frame0.transform, frame1.transform, easeValue);
        }
        return;
      } else {
        frameOffset = frameEnd;
      }
    }

    transform.reset();
  }



}
