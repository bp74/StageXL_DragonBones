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

      var animationBoneFrame1 = frames[i + 0];
      var animationBoneFrame2 = frames[i + 1];
      var frameEnd = frameOffset + animationBoneFrame1.duration;

      if (framePosition >= frameOffset && framePosition < frameEnd) {

        var duration = animationBoneFrame1.duration;
        var tweenEasing = animationBoneFrame1.tweenEasing ?? 0.0;
        var progress = (framePosition - frameOffset) / duration;
        var easeValue = _getEaseValue(progress, tweenEasing);

        var t1 = animationBoneFrame1.transform;
        var t2 = animationBoneFrame2.transform;

        transform.tween(t1, t2, easeValue);
        return;
      }

      frameOffset += animationBoneFrame1.duration;
    }

    transform.reset();
  }



}
