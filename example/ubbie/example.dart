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
  var stage = Stage(canvas, width: 1000, height: 1000);
  var renderLoop = RenderLoop();
  renderLoop.addStage(stage);

  // load the skeleton resources

  var resourceManager = ResourceManager();
  resourceManager.addTextureAtlas("dragonTexture", "assets/texture.json", TextureAtlasFormat.STARLINGJSON);
  resourceManager.addTextFile("dragonJson", "assets/ubbie.json");
  await resourceManager.load();

  // create a skeleton and play the "walk" animation

  var textureAtlas = resourceManager.getTextureAtlas("dragonTexture");
  var dragonBonesJson = resourceManager.getTextFile("dragonJson");
  var dragonBones = DragonBones.fromJson(dragonBonesJson);
  var skeleton = dragonBones.createSkeleton("ubbie");

  skeleton.setSkin(textureAtlas);
  skeleton.play("stand");
  skeleton.x = 350;
  skeleton.y = 800;
  skeleton.showBones = false;
  stage.juggler.add(skeleton);
  stage.addChild(skeleton);

}

