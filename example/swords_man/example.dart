import 'dart:async';
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_dragonbones/stagexl_dragonbones.dart';

Future main() async {

  // configure StageXL default options

  StageXL.stageOptions.renderEngine = RenderEngine.WebGL;
  StageXL.stageOptions.backgroundColor = Color.AliceBlue;
  StageXL.bitmapDataLoadOptions.webp = false;

  // init Stage and RenderLoop

  var canvas = html.querySelector('#stage');
  var stage = Stage(canvas, width: 900, height: 900);
  var renderLoop = RenderLoop();
  renderLoop.addStage(stage);

  // load the skeleton resources

  var resourceManager = ResourceManager();
  resourceManager.addTextureAtlas("smTexture", "assets/texture.json", TextureAtlasFormat.STARLINGJSON);
  resourceManager.addTextFile("smJson", "assets/swords_man.json");
  await resourceManager.load();

  // create a skeleton and play the "steady2" animation

  var textureAtlas = resourceManager.getTextureAtlas("smTexture");
  var dragonBonesJson = resourceManager.getTextFile("smJson");
  var dragonBones = DragonBones.fromJson(dragonBonesJson);
  var skeleton = dragonBones.createSkeleton("Swordsman");

  skeleton.setSkin(textureAtlas);
  skeleton.play("steady2");
  skeleton.x = 500;
  skeleton.y = 750;
  skeleton.showBones = false;
  stage.juggler.add(skeleton);
  stage.addChild(skeleton);

}

