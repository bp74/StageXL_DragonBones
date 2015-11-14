import 'dart:async';
import 'dart:math' as math;
import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';
import 'package:stagexl_dragonbones/stagexl_dragonbones.dart';

Future main() async {

  // configure StageXL default options

  StageXL.stageOptions.renderEngine = RenderEngine.Canvas2D;
  StageXL.stageOptions.backgroundColor = Color.AliceBlue;
  StageXL.bitmapDataLoadOptions.webp = false;

  // init Stage and RenderLoop

  var canvas = html.querySelector('#stage');
  var stage = new Stage(canvas, width: 1600, height: 1000);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);

  // load the skeleton resources

  var resourceManager = new ResourceManager();
  resourceManager.addTextureAtlas("dragonTexture", "assets/texture.json");
  resourceManager.addTextFile("dragonJson", "assets/dragon.json");
  await resourceManager.load();

  // add TextField to show user information

  var textField = new TextField();
  textField.defaultTextFormat = new TextFormat("Arial", 40, Color.Black);
  textField.defaultTextFormat.align = TextFormatAlign.CENTER;
  textField.width = 1000;
  textField.x = 300;
  textField.y = 900;
  textField.text = "tap to change animation";
//  textField.addTo(stage);

  var textureAtlas = resourceManager.getTextureAtlas("dragonTexture");
  var dragonBonesJson = resourceManager.getTextFile("dragonJson");
  var dragonBones = DragonBones.fromJson(dragonBonesJson);
  var skeleton = dragonBones.createSkeleton("Dragon");
  skeleton.setSkin(textureAtlas);
  skeleton.play("walk");
  skeleton.x = 800;
  skeleton.y = 500;
  stage.juggler.add(skeleton);
  stage.addChild(skeleton);

}

