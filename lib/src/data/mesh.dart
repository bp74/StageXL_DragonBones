part of stagexl_dragonbones;

class Mesh extends Display {

  final Float32List vertices;
  final Float32List uvs;
  final Int16List triangles;
  final Int16List edges;

  Mesh(String name, String type, Transform transform,
      this.vertices, this.uvs, this.triangles, this.edges)
      : super(name, type, transform);

}