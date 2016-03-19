part of stagexl_dragonbones;

class Animation {

  final String name;
  final int duration;
  final int playTimes;

  final List<AnimationSlot> slots;
  final List<AnimationBone> bones;
  final List<AnimationFfd> ffds;

  Animation(
      this.name,
      this.duration,
      this.playTimes,
      this.bones,
      this.slots,
      this.ffds);

  //---------------------------------------------------------------------------

  AnimationBone getAnimationBone(String boneName) {
    for (var animationBone in bones) {
      if (animationBone.name == boneName) {
        return animationBone;
      }
    }
    return null;
  }

  AnimationSlot getAnimationSlot(String slotName) {
    for (var animationSlot in slots) {
      if (animationSlot.name == slotName) {
        return animationSlot;
      }
    }
    return null;
  }

  AnimationFfd getAnimationFfd(String ffdName) {
    for (var animatonFfd in ffds) {
      if (animatonFfd.name == ffdName) {
        return animatonFfd;
      }
    }
    return null;
  }

  //---------------------------------------------------------------------------

  @override
  String toString() => "Animation '$name'";
}
