part of stagexl_dragonbones;

class Animation {

  final String name;
  final int duration;
  final int playTimes;

  final List<AnimationBone> bones;
  final List<AnimationSlot> slots;
  final List<AnimationFree> frees;

  Animation(
      this.name,
      this.duration,
      this.playTimes,
      this.bones,
      this.slots,
      this.frees);

  //---------------------------------------------------------------------------

  AnimationBone getAnimationBone(String boneName) {
    for (var bone in bones) {
      if (bone.name == boneName) return bone;
    }
    return null;
  }

  AnimationSlot getAnimationSlot(String slotName) {
    for (var slot in slots) {
      if (slot.name == slotName) return slot;
    }
    return null;
  }

  AnimationFree getAnimationFree(String slotName, String skinName) {
    for (var free in frees) {
      if (free.slotName == slotName && free.skinName == skinName) return free;
    }
    return null;
  }

  //---------------------------------------------------------------------------

  @override
  String toString() => "Animation '$name'";
}
