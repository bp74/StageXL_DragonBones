part of stagexl_dragonbones;

class Skin {

  final String name;
  final List<SkinSlot> slots;

  Skin(this.name, this.slots);

  //---------------------------------------------------------------------------

  SkinSlot getSkinSlot(String slotName) {
    for (var skinSlot in slots) {
      if (skinSlot.name == slotName) {
        return skinSlot;
      }
    }
    return null;
  }

  //---------------------------------------------------------------------------

  @override
  String toString() => "Skin '$name'";
}
