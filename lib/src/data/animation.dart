part of stagexl_dragonbones;

class Animation {

  final String name;
  final int duration;
  final int playTimes;

  final List<AnimationSlot> slots;
  final List<AnimationBone> bones;

  Animation(
      this.name,
      this.duration,
      this.playTimes,
      this.bones,
      this.slots);

  //---------------------------------------------------------------------------

  AnimationBone getAnimationBone(String boneName) {
    for(var animationBone in bones) {
      if (animationBone.name == boneName) {
        return animationBone;
      }
    }
    return null;
  }

  AnimationSlot getAnimationSlot(String slotName) {
    for(var animationSlot in slots) {
      if (animationSlot.name == slotName) {
        return animationSlot;
      }
    }
    return null;
  }

  //---------------------------------------------------------------------------

  @override
  String toString() => "Animation '$name'";
}
