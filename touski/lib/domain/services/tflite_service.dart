import 'dart:typed_data';
import 'package:image/image.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:touski/domain/entities/detection.dart';
import 'package:touski/domain/entities/food_classes.dart';

class TfliteService {
  late Interpreter interpreter;

  TfliteService();

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset('assets/models/food_model.tflite');
  }

  Future<List<Detection>> processImage(Image image, int inputSize) async {
    const int maxDetections = 300;
    const double confidenceThreshold = 0.4;

    final Float32List input = Float32List(inputSize * inputSize * 3);
    int idx = 0;

    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final p = image.getPixel(x, y);
        input[idx++] = p.r / 255.0;
        input[idx++] = p.g / 255.0;
        input[idx++] = p.b / 255.0;
      }
    }

    final output = List.filled(1 * maxDetections * 6, 0.0).reshape([1, maxDetections, 6]);

    interpreter.run(input.reshape([1, inputSize, inputSize, 3]), output,);

    final List<Detection> detections = [];

    for (int i = 0; i < maxDetections; i++) {
      final double score = output[0][i][4];
      if (score < confidenceThreshold) continue;

      final int classIndex = output[0][i][5].toInt();

      final cx = output[0][i][0];
      final cy = output[0][i][1];
      final bw = output[0][i][2];
      final bh = output[0][i][3];

      final box = Box(x: cx, y: cy, w: bw, h: bh);

      detections.add(
        Detection(
          foodClass: foodClasses[classIndex],
          score: score,
          box: box,
        ),
      );
    }
    return detections;
  }
}

