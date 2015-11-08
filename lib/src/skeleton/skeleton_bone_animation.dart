part of stagexl_dragonbones;

class SkeletonBoneAnimation {

  final Animation animation;
  final AnimationBone animationBone;
  final Transform transform = new Transform();

  SkeletonBoneAnimation(this.animation, this.animationBone);

  //---------------------------------------------------------------------------

  void updateTransform(double time) {

    var frames = animationBone.frames;
    var frameRate = 24; // TODO
    var framePosition = (time * frameRate) % animation.duration;
    var frameOffset = 0.0;

    for(int i = 0; i < frames.length - 1; i++) {

      var frame0 = frames[i + 0];
      var frame1 = frames[i + 1];
      var frameDuration = frame0.duration;
      var frameEnd = frameOffset + frameDuration;

      if (framePosition >= frameOffset && framePosition < frameEnd) {
        var tweenEasing = frame0.tweenEasing ?? 0.0;
        var progress = (framePosition - frameOffset) / frameDuration;
        var easeValue = _getEaseValue(progress, tweenEasing);
        transform.tween(frame0.transform, frame1.transform, easeValue);
        return;
      } else {
        frameOffset = frameEnd;
      }
    }

    transform.reset();
  }



}
