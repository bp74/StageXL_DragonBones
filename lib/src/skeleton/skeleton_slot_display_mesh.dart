part of stagexl_dragonbones;

class SkeletonSlotDisplayMesh extends SkeletonSlotDisplay {

  final RenderTextureQuad renderTextureQuad;
  final Float32List vxList;
  final Int16List ixList;

  SkeletonSlotDisplayMesh(DisplayMesh mesh, this.renderTextureQuad)
      : this.vxList = new Float32List(mesh.vertices.length + mesh.uvs.length),
        this.ixList = mesh.triangles,
        super(mesh) {

    var samplerMatrix = this.renderTextureQuad.samplerMatrix;
    var ma = samplerMatrix.a * renderTextureQuad.targetWidth;
    var mb = samplerMatrix.b * renderTextureQuad.targetWidth;
    var mc = samplerMatrix.c * renderTextureQuad.targetHeight;
    var md = samplerMatrix.d * renderTextureQuad.targetHeight;
    var mx = samplerMatrix.tx;
    var my = samplerMatrix.ty;

    for (int i = 0, o = 0; i < mesh.vertices.length - 1; i += 2, o += 4) {
      vxList[i * 2 + 0] = mesh.vertices[i + 0];
      vxList[i * 2 + 1] = mesh.vertices[i + 1];
    }

    for (int i = 0, o = 0; i < mesh.uvs.length - 1; i += 2, o += 4) {
      var u = mesh.uvs[i + 0];
      var v = mesh.uvs[i + 1];
      vxList[o + 2] = u * ma + v * mc + mx;
      vxList[o + 3] = u * mb + v * md + my;
    }
  }

  //---------------------------------------------------------------------------

  @override
  void render(RenderState renderState) {

    // TODO: add Free Form Deformation

    var renderTexture = this.renderTextureQuad.renderTexture;

    renderState.renderTextureMesh(renderTexture, ixList, vxList);
  }
}

