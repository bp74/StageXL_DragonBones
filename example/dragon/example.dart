import 'dart:async';
import 'dart:math' as math;
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
  var stage = new Stage(canvas, width: 800, height: 900);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // load the skeleton resources

  var resourceManager = new ResourceManager();
  resourceManager.addTextureAtlas("dragonTexture", "assets/texture.json", TextureAtlasFormat.STARLINGJSON);
  resourceManager.addTextFile("dragonJson", "assets/dragon.json");
  await resourceManager.load();

  // create a skeleton and play the "walk" animation

  var textureAtlas = resourceManager.getTextureAtlas("dragonTexture");
  var dragonBonesJson = resourceManager.getTextFile("dragonJson");
  var dragonBones = DragonBones.fromJson(dragonBonesJson);
  var skeleton = dragonBones.createSkeleton("Dragon");

  skeleton.setSkin(textureAtlas);
  skeleton.play("walk");
  skeleton.x = 300;
  skeleton.y = 500;
  stage.juggler.add(skeleton);
  stage.addChild(skeleton);

}

