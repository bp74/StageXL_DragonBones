part of stagexl_dragonbones;

class Display {

  final String name;
  final String type;
  final Transform transform;

  Display(this.name, this.type, this.transform);

  //---------------------------------------------------------------------------

  @override
  String toString() => "Display($type) '$name' ";
}

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------

class DisplayMesh extends Display {

  final Float32List vertices;
  final Float32List uvs;
  final Int16List triangles;
  final Int16List edges;

  DisplayMesh(
      String name, String type, Transform transform,
      this.vertices, this.uvs, this.triangles, this.edges)
      : super(name, type, transform);
}
