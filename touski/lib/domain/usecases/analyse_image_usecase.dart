import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:touski/domain/entities/analysis_result.dart';
import 'package:touski/domain/services/tflite_service.dart';
import 'package:touski/presentation/app/app_setup.dart';

class AnalyseImageUsecase {
  final TfliteService tfliteService = locator<TfliteService>();

  AnalyseImageUsecase();

  Future<AnalysisResult> execute(Uint8List imageBytes) async {
    final decoded = img.decodeImage(imageBytes)!;
    final analysis = await tfliteService.analyzeImage(imageBytes);

    return AnalysisResult(
      imageBytes: analysis.imageBytes,
      detectedFoods: analysis.detectedFoods,
    );
  }

}
