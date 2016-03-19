part of stagexl_dragonbones;

class SkeletonSlotDisplayImage extends SkeletonSlotDisplay {

  final RenderTextureQuad renderTextureQuad;

  SkeletonSlotDisplayImage(Display display, this.renderTextureQuad)
      : super(display) {

    var pivotX = renderTextureQuad.targetWidth / 2;
    var pivotY = renderTextureQuad.targetHeight / 2;
    this.matrix.prependTranslation(-pivotX, -pivotY);
  }

  //---------------------------------------------------------------------------

  @override
  void render(RenderState renderState) {

    // colorTransform.redMultiplier,
    // colorTransform.greenMultiplier,
    // colorTransform.blueMultiplier,
    // colorTransform.alphaMultiplier

    renderState.renderTextureQuad(this.renderTextureQuad);
  }

}
