part of stagexl_dragonbones;

class Animation {

  final String name;
  final int duration;
  final int playTimes;

  final List<AnimationBone> bones;
  final List<AnimationSlot> slots;
  final List<AnimationForm> forms;

  Animation(
      this.name,
      this.duration,
      this.playTimes,
      this.bones,
      this.slots,
      this.forms);

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

  AnimationForm getAnimationFree(String slotName, String skinName) {
    for (var form in forms) {
      if (form.slotName == slotName && form.skinName == skinName) return form;
    }
    return null;
  }

  //---------------------------------------------------------------------------

  @override
  String toString() => "Animation '$name'";
}
