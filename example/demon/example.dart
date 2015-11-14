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
  var stage = new Stage(canvas, width: 900, height: 700);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // load the skeleton resources

  var resourceManager = new ResourceManager();
  resourceManager.addTextureAtlas("demonTexture", "assets/texture.json");
  resourceManager.addTextFile("demonJson", "assets/demon.json");
  await resourceManager.load();

  // create a skeleton and play the "run" animation

  var textureAtlas = resourceManager.getTextureAtlas("demonTexture");
  var dragonBonesJson = resourceManager.getTextFile("demonJson");
  var dragonBones = DragonBones.fromJson(dragonBonesJson);
  var skeleton = dragonBones.createSkeleton("armatureName");

  skeleton.setSkin(textureAtlas);
  skeleton.play("run");
  skeleton.play("stun");
  skeleton.x = 320;
  skeleton.y = 600;
  skeleton.showBones = true;
  stage.juggler.add(skeleton);
  stage.addChild(skeleton);

}

