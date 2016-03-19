part of stagexl_dragonbones;

abstract class SkeletonSlotDisplay {

  final Display display;
  final Matrix matrix = new Matrix.fromIdentity();

  SkeletonSlotDisplay(this.display) {
    matrix.copyFrom(display.transform.matrix);
  }

  //---------------------------------------------------------------------------

  void render(RenderState renderState);
}
