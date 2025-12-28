import 'dart:math';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_processing/tflite_flutter_processing.dart';
import 'package:touski/domain/entities/detection.dart';
import 'package:touski/domain/entities/food_classes.dart';

class TfliteService {
  final String modelName = 'assets/models/food_model.tflite';

  late Interpreter interpreter;
  late InterpreterOptions interpreterOptions;

  late List<int> _inputShape;
  late TensorImage _inputImage;
  late TensorType _inputType;

  final preProcessNormalizeOp = NormalizeOp(127.5, 127.5);

  TfliteService() {
    interpreterOptions = InterpreterOptions();
    interpreterOptions.threads = 1;
  }

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset(modelName, options: interpreterOptions);

    _inputShape = interpreter.getInputTensor(0).shape;
    _inputType = interpreter.getInputTensor(0).type;

    _inputImage = TensorImage(_inputType);
  }

  TensorImage _preProcess(img.Image image) {
    int cropSize = min(image.height, image.width);
    return ImageProcessorBuilder()
        .add(ResizeWithCropOrPadOp(cropSize, cropSize))
        .add(ResizeOp(_inputShape[1], _inputShape[2], ResizeMethod.NEAREST_NEIGHBOUR))
        .add(preProcessNormalizeOp)
        .build()
        .process(_inputImage..loadImage(image));
  }

  List<Detection> processImage(img.Image image, {double threshold = 0.5}) {
    _inputImage = _preProcess(image);

    final outputLocations = TensorBufferFloat([1, 10, 4]);
    final outputClasses = TensorBufferFloat([1, 10]);
    final outputScores = TensorBufferFloat([1, 10]);
    final numDetections = TensorBufferFloat([1]);

    interpreter.runForMultipleInputs(
      [_inputImage.buffer],
      {
        0: outputLocations.buffer,
        1: outputClasses.buffer,
        2: outputScores.buffer,
        3: numDetections.buffer,
      },
    );

    List<Detection> detections = [];
    final count = numDetections.getIntValue(0);

    for (int i = 0; i < count; i++) {
      final score = outputScores.getDoubleValue(i);
      if (score < threshold) continue;

      final classIndex = outputClasses.getIntValue(i);
      final boxStart = i * 4;
      final box = outputLocations.getDoubleList().sublist(boxStart, boxStart + 4);

      detections.add(Detection(foodClasses[classIndex], score, box));
    }

    return detections;
  }

  void close() {
    interpreter.close();
  }
}
