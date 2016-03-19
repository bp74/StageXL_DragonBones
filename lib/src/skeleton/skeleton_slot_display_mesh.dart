part of stagexl_dragonbones;

class SkeletonSlotDisplayMesh extends SkeletonSlotDisplay {

  final RenderTextureQuad renderTextureQuad;

  SkeletonSlotDisplayMesh(DisplayMesh display, this.renderTextureQuad)
      : super(display) {

    var pivotX = renderTextureQuad.targetWidth / 2;
    var pivotY = renderTextureQuad.targetHeight / 2;
    this.matrix.prependTranslation(-pivotX, -pivotY);
  }

  //---------------------------------------------------------------------------

  @override
  void render(RenderState renderState) {
   // renderState.renderTextureQuad(this.renderTextureQuad);
  }
}

