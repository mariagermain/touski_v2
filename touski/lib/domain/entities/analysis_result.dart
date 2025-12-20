import 'package:image/image.dart' as img;

class AnalysisResult {
  final img.Image annotatedImage;
  final List<String> detectedFoods;

  AnalysisResult({
    required this.annotatedImage,
    required this.detectedFoods,
  });

  img.Image get _annotatedImage => annotatedImage;
  List<String> get _detectedFoods => detectedFoods;
}
