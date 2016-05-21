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
  var stage = new Stage(canvas, width: 1500, height: 1500);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // load the skeleton resources

  var resourceManager = new ResourceManager();
  resourceManager.addTextureAtlas("bicycleTexture", "assets/texture.json", TextureAtlasFormat.STARLINGJSON);
  resourceManager.addTextFile("bicycleJson", "assets/bicycle.json");
  await resourceManager.load();

  // create a skeleton and play the "steady2" animation

  var textureAtlas = resourceManager.getTextureAtlas("bicycleTexture");
  var dragonBonesJson = resourceManager.getTextFile("bicycleJson");
  var dragonBones = DragonBones.fromJson(dragonBonesJson);
  var skeleton = dragonBones.createSkeleton("Bicycle");

  skeleton.setSkin(textureAtlas);
  skeleton.play("bicycle");
  skeleton.x = 750;
  skeleton.y = 1400;
  skeleton.showBones = false;
  stage.juggler.add(skeleton);
  stage.addChild(skeleton);

}

