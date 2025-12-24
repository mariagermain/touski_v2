import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:touski/domain/entities/analysis_result.dart';
import 'package:touski/domain/entities/class_names.dart';

class TfliteService {
  final Interpreter interpreter;

  TfliteService({required this.interpreter});

Future<AnalysisResult> analyzeImage(Uint8List bytes) async {
  final img.Image? image = img.decodeImage(bytes);

  const inputSize = 640;
  final resized = img.copyResize(image!, width: 640, height: 640);

  Float32List input = Float32List(640 * 640 * 3);
  int idx = 0;

  for (int y = 0; y < 640; y++) {
    for (int x = 0; x < 640; x++) {
      final p = resized.getPixel(x, y);
      input[idx++] = p.r / 255.0;
      input[idx++] = p.g / 255.0;
      input[idx++] = p.b / 255.0;
    }
  }

  var output = List.filled(1 * 40 * 8400, 0.0).reshape([1, 40, 8400]);
  interpreter.run(input.reshape([1, 640, 640, 3]), output);

  const double confidenceThreshold = 0.5;
  const int numPredictions = 8400;
  const int numClasses = 35;

  final Set<String> detectedFoods = {};
  for (int i = 0; i < numPredictions; i++) {
    final double objectness = output[0][4][i];
    if (objectness < confidenceThreshold) continue;

    // Find best class
    double bestClassScore = 0.0;
    int bestClassIndex = -1;

    for (int c = 0; c < numClasses; c++) {
      final double score = output[0][4 + c][i];
      if (score > bestClassScore) {
        bestClassScore = score;
        bestClassIndex = c;
      }
    }

    final double confidence = objectness * bestClassScore;
    if(confidence < confidenceThreshold) continue;
    final double cx = output[0][0][i];
    final double cy = output[0][1][i];
    final double w = output[0][2][i];
    final double h = output[0][3][i];

    final int left =
        ((cx - w / 2) * inputSize).clamp(0, inputSize - 1).toInt();
    final int top =
        ((cy - h / 2) * inputSize).clamp(0, inputSize - 1).toInt();
    final int right =
        ((cx + w / 2) * inputSize).clamp(0, inputSize - 1).toInt();
    final int bottom =
        ((cy + h / 2) * inputSize).clamp(0, inputSize - 1).toInt();

    img.drawRect(
      resized,
      x1: left,
      y1: top,
      x2: right,
      y2: bottom,
      color: img.ColorRgb8(255, 0, 0),
      thickness: 3,
    );

    final String label =
        '${classNames[bestClassIndex]} ${(confidence * 100).toStringAsFixed(1)}%';

    img.drawString(
      resized,
      font: img.arial14,
      x: left,
      y: (top - 16).clamp(0, inputSize - 1),
      label,
      color: img.ColorRgb8(255, 0, 0),
    );

    detectedFoods.add(classNames[bestClassIndex]);
  }

  final Uint8List annotatedBytes = Uint8List.fromList(img.encodePng(resized));

  return AnalysisResult(
    imageBytes: annotatedBytes,
    detectedFoods: detectedFoods.toList(),
  );
  }
}


