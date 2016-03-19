part of stagexl_dragonbones;

abstract class SkeletonSlotDisplay {

  final Display display;
  final Matrix matrix = new Matrix.fromIdentity();

  SkeletonSlotDisplay(this.display) {
    matrix.copyFrom(display.transform.matrix);
  }
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
}

//-----------------------------------------------------------------------------

class SkeletonSlotDisplayMesh extends SkeletonSlotDisplay {

  final RenderTextureQuad renderTextureQuad;

  SkeletonSlotDisplayMesh(DisplayMesh display, this.renderTextureQuad)
      : super(display) {

    var pivotX = renderTextureQuad.targetWidth / 2;
    var pivotY = renderTextureQuad.targetHeight / 2;
    this.matrix.prependTranslation(-pivotX, -pivotY);
  }
}

//-----------------------------------------------------------------------------

class SkeletonSlotDisplayArmature extends SkeletonSlotDisplay {

  SkeletonSlotDisplayArmature(Display display) : super(display);

}
