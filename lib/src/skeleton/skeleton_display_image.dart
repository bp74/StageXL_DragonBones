part of stagexl_dragonbones;

class SkeletonDisplayImage extends SkeletonDisplay {

  final RenderTextureQuad renderTextureQuad;

  SkeletonDisplayImage(Display display, this.renderTextureQuad)
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
