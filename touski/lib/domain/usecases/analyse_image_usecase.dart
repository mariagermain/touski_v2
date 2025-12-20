import 'dart:io';
import 'package:image/image.dart';
import 'package:touski/domain/entities/analysis_result.dart';
import 'package:touski/domain/services/tflite_service.dart';

class AnalyseImageUsecase {
  final TfliteService tfliteService;

  AnalyseImageUsecase({required this.tfliteService});

 Future<(Image, List<String>)> execute(File image) async {
    AnalysisResult analysis = await analyseImage(image);
    return (analysis.annotatedImage, analysis.detectedFoods);
  }

  Future<AnalysisResult> analyseImage(File image) async {
    final analysis = await tfliteService.analyzeImage(image);

    return AnalysisResult(
      annotatedImage: analysis.annotatedImage,
      detectedFoods: analysis.detectedFoods,
    );
  }

}
