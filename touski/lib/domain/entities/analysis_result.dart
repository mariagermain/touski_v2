import 'package:image/image.dart';

class AnalysisResult {
  Image image;
  List<String> detectedFoods;

  AnalysisResult({required this.image, required this.detectedFoods});
}