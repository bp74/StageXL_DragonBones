part of stagexl_dragonbones;

class DisplayImage extends Display {

  final Bitmap bitmap = new Bitmap();

  DisplayImage(String name) : super(name);

  @override
  String toString() => "DisplayImage '$name'";

}
