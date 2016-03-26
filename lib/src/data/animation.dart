part of stagexl_dragonbones;

class Animation {

  final String name;
  final int duration;
  final int playTimes;

  final List<BoneAnimation> boneAnimations;
  final List<SlotAnimation> slotAnimations;
  final List<MeshAnimation> meshAnimations;

  Animation(
      this.name,
      this.duration,
      this.playTimes,
      this.boneAnimations,
      this.slotAnimations,
      this.meshAnimations);

  //---------------------------------------------------------------------------

  BoneAnimation getBoneAnimation(String boneName) {
    for (var animation in boneAnimations) {
      if (animation.name == boneName) return animation;
    }
    return null;
  }

  SlotAnimation getSlotAnimation(String slotName) {
    for (var animation in slotAnimations) {
      if (animation.name == slotName) return animation;
    }
    return null;
  }

  MeshAnimation getMeshAnimation(String slotName, String skinName) {
    for (var animation in meshAnimations) {
      if (animation.slotName == slotName &&
          animation.skinName == skinName) return animation;
    }
    return null;
  }

  //---------------------------------------------------------------------------

  @override
  String toString() => "Animation '$name'";
}
