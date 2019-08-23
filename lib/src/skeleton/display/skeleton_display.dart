part of stagexl_dragonbones;

abstract class SkeletonDisplay extends SkeletonObject {

  final Display display;
  final Matrix matrix = Matrix.fromIdentity();

  SkeletonDisplay(this.display) {
    matrix.copyFrom(display.transform.matrix);
  }

  //---------------------------------------------------------------------------

  void render(RenderState renderState);
}
