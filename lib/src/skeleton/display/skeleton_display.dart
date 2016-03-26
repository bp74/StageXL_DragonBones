part of stagexl_dragonbones;

abstract class SkeletonDisplay {

  final Display display;
  final Matrix matrix = new Matrix.fromIdentity();

  SkeletonDisplay(this.display) {
    matrix.copyFrom(display.transform.matrix);
  }

  //---------------------------------------------------------------------------

  void render(RenderState renderState);
}
