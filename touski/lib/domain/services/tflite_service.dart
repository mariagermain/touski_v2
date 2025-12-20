import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:touski/domain/entities/analysis_result.dart';

class TfliteService {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('models/foods_model.tflite');
  }

  Future<AnalysisResult> analyzeImage(File imageFile) async {
    final imageBytes = await imageFile.readAsBytes();
    img.Image image = img.decodeImage(imageBytes)!;

    const inputSize = 300;
    img.Image resized = img.copyResize(image, width: inputSize, height: inputSize);

    Float32List input = Float32List(inputSize * inputSize * 3);
    int index = 0;
    for (int y = 0; y < inputSize; y++) {
        for (int x = 0; x < inputSize; x++) {
          final pixel = resized.getPixel(x, y); 
          input[index++] = pixel.r / 255.0; 
          input[index++] = pixel.g / 255.0; 
          input[index++] = pixel.b / 255.0;
        }
    }

    var outputLocations = List.filled(1 * 10 * 4, 0.0).reshape([1, 10, 4]); 
    var outputClasses = List.filled(1 * 10, 0.0).reshape([1, 10]);          
    var outputScores = List.filled(1 * 10, 0.0).reshape([1, 10]);           
    var numDetections = List.filled(1, 0.0).reshape([1]);                   

    _interpreter.run(input.reshape([1, inputSize, inputSize, 3]), {
      0: outputLocations,
      1: outputClasses,
      2: outputScores,
      3: numDetections,
    });


    final List<String> detectedFoods = [];
    for (int i = 0; i < numDetections[0].toInt(); i++) {
      double score = outputScores[0][i];
      if (score < 0.5) continue; 

      int classIndex = outputClasses[0][i].toInt();
      detectedFoods.add('Food #$classIndex'); 

      double yMin = outputLocations[0][i][0] * image.height;
      double xMin = outputLocations[0][i][1] * image.width;
      double yMax = outputLocations[0][i][2] * image.height;
      double xMax = outputLocations[0][i][3] * image.width;

      img.drawRect(image, x1: xMin.toInt(), y1: yMin.toInt(), x2: xMax.toInt(), y2: yMax.toInt(), color: img.ColorRgb8(255, 0, 0));
    }

    return AnalysisResult(annotatedImage: image, detectedFoods: detectedFoods);
  }
}
