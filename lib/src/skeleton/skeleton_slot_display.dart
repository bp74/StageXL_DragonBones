part of stagexl_dragonbones;

abstract class SkeletonSlotDisplay {

  final Display display;
  final Matrix matrix = new Matrix.fromIdentity();

  SkeletonSlotDisplay(this.display) {
    matrix.copyFrom(display.transform.matrix);
  }

  void render(RenderState renderState);

}

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

class SkeletonSlotDisplayImage extends SkeletonSlotDisplay {

  final RenderTextureQuad renderTextureQuad;

  SkeletonSlotDisplayImage(Display display, this.renderTextureQuad)
      : super(display) {

    var pivotX = renderTextureQuad.targetWidth / 2;
    var pivotY = renderTextureQuad.targetHeight / 2;
    this.matrix.prependTranslation(-pivotX, -pivotY);
  }

  @override
  void render(RenderState renderState) {
    renderState.globalMatrix.prepend(matrix);
    renderState.renderTextureQuad(renderTextureQuad);
  }
}

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

class SkeletonSlotDisplayArmature extends SkeletonSlotDisplay {

  SkeletonSlotDisplayArmature(Display display)
      : super(display);

  @override
  void render(RenderState renderState) {

  }
}
