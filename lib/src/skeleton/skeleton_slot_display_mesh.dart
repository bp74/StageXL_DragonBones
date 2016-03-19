part of stagexl_dragonbones;

class SkeletonSlotDisplayMesh extends SkeletonSlotDisplay {

  final RenderTextureQuad renderTextureQuad;

  SkeletonSlotDisplayMesh(DisplayMesh display, this.renderTextureQuad)
      : super(display) {

    // var pivotX = renderTextureQuad.targetWidth / 2;
    // var pivotY = renderTextureQuad.targetHeight / 2;
    // this.matrix.prependTranslation(-pivotX, -pivotY);
  }

  //---------------------------------------------------------------------------

  @override
  void render(RenderState renderState) {

    // TODO: add Free Form Deformation
    // TODO: make it fast, this is just a proof of concept

    var renderTextureQuad = this.renderTextureQuad;
    var renderTexture = renderTextureQuad.renderTexture;
    var samplerMatrix = renderTextureQuad.samplerMatrix;

    var ma = samplerMatrix.a * renderTextureQuad.targetWidth;
    var mb = samplerMatrix.b * renderTextureQuad.targetWidth;
    var mc = samplerMatrix.c * renderTextureQuad.targetHeight;
    var md = samplerMatrix.d * renderTextureQuad.targetHeight;
    var mx = samplerMatrix.tx;
    var my = samplerMatrix.ty;

    var displayMesh = this.display as DisplayMesh;
    var vertices = displayMesh.vertices;
    var uvs = displayMesh.uvs;
    var ixList = displayMesh.triangles;
    var vxList = new Float32List(vertices.length + uvs.length);

    for (int i = 0, o = 0; i < vertices.length - 1; i += 2, o += 4) {
      vxList[i * 2 + 0] = vertices[i + 0];
      vxList[i * 2 + 1] = vertices[i + 1];
    }

    for (int i = 0, o = 0; i < uvs.length - 1; i+= 2, o += 4) {
      var u = uvs[i + 0];
      var v = uvs[i + 1];
      vxList[o + 2] = u * ma + v * mc + mx;
      vxList[o + 3] = u * mb + v * md + my;
    }

    renderState.renderTextureMesh(renderTexture, ixList, vxList);
  }
}

