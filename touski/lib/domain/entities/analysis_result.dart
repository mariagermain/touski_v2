import 'dart:typed_data';

import 'package:image/image.dart';

class AnalysisResult {
  final Uint8List imageBytes;
  final List<String> detectedFoods;

  AnalysisResult({
    required this.imageBytes,
    required this.detectedFoods,
  });

  Uint8List get _annotatedBytes => imageBytes;
  List<String> get _detectedFoods => detectedFoods;
}
