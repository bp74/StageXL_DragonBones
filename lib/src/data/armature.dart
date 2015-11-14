part of stagexl_dragonbones;

class Armature {

  final String name;
  final List<Bone> bones;
  final List<Slot> slots;
  final List<Skin> skins;
  final List<Animation> animations;

  Armature(this.name, this.bones, this.slots, this.skins, this.animations);

  //---------------------------------------------------------------------------

  Animation getAnimation(String animationName) {
    for (var animation in this.animations) {
      if (animation.name == animationName) {
        return animation;
      }
    }
    return null;
  }

  Skin getSkin(String skinName) {
    for (var skin in this.skins) {
      if (skin.name == skinName) {
        return skin;
      }
    }
    return null;
  }

  //---------------------------------------------------------------------------

  @override
  String toString() => "Armature '$name'";

}
