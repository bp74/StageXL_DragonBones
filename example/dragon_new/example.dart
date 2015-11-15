import 'dart:async';
import 'dart:math' as math;
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_dragonbones/stagexl_dragonbones.dart';

Future main() async {

  // configure StageXL default options

  StageXL.stageOptions.renderEngine = RenderEngine.WebGL;
  StageXL.stageOptions.backgroundColor = Color.AliceBlue;
  StageXL.bitmapDataLoadOptions.webp = true;

  // init Stage and RenderLoop

  var canvas = html.querySelector('#stage');
  var stage = new Stage(canvas, width: 1000, height: 700);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // load the skeleton resources

  var resourceManager = new ResourceManager();
  resourceManager.addTextureAtlas("dragonTexture", "assets/texture.json");
  resourceManager.addTextFile("dragonJson", "assets/dragon_new.json");
  await resourceManager.load();

  // create a skeleton and play the "stand" animation

  var textureAtlas = resourceManager.getTextureAtlas("dragonTexture");
  var dragonBonesJson = resourceManager.getTextFile("dragonJson");
  var dragonBones = DragonBones.fromJson(dragonBonesJson);
  var skeleton = dragonBones.createSkeleton("armatureName");

  skeleton.setSkin(textureAtlas);
  skeleton.play("stand");
  skeleton.x = 430;
  skeleton.y = 520;
  skeleton.showBones = false;
  stage.juggler.add(skeleton);
  stage.addChild(skeleton);

}
