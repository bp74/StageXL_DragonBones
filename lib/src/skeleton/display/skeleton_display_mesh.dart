part of stagexl_dragonbones;

class SkeletonDisplayMesh extends SkeletonDisplay {

  final RenderTextureQuad renderTextureQuad;
  final Float32List vxList;
  final Int16List ixList;

  SkeletonDisplayMesh(Mesh mesh, this.renderTextureQuad)
      : this.vxList = new Float32List(mesh.vertices.length + mesh.uvs.length),
        this.ixList = mesh.triangles,
        super(mesh) {

    var sm = renderTextureQuad.samplerMatrix;
    var tw = renderTextureQuad.targetWidth;
    var th = renderTextureQuad.targetHeight;

    for (int i = 0, o = 0; i < mesh.vertices.length - 1; i += 2, o += 4) {
      vxList[o + 0] = mesh.vertices[i + 0];
      vxList[o + 1] = mesh.vertices[i + 1];
    }

    for (int i = 0, o = 0; i < mesh.uvs.length - 1; i += 2, o += 4) {
      var x = mesh.uvs[i + 0] * tw;
      var y = mesh.uvs[i + 1] * th;
      vxList[o + 2] = x * sm.a + y * sm.c + sm.tx;
      vxList[o + 3] = x * sm.b + y * sm.d + sm.ty;
    }
  }

  //---------------------------------------------------------------------------

  void resetVertices() {
    Mesh mesh = this.display;
    Float32List vertices = mesh.vertices;
    for (int i = 0, o = 0; i < vertices.length - 1; i += 2, o += 4) {
      vxList[o + 0] = vertices[i + 0];
      vxList[o + 1] = vertices[i + 1];
    }
  }

  //---------------------------------------------------------------------------

  @override
  void render(RenderState renderState) {
    var renderTexture = this.renderTextureQuad.renderTexture;
    renderState.renderTextureMesh(renderTexture, ixList, vxList);
  }
}

