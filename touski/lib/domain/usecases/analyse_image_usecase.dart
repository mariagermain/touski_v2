import 'package:image/image.dart';
import 'package:image/image.dart' as img;
import 'package:touski/domain/entities/analysis_result.dart';
import 'package:touski/domain/entities/detection.dart';
import 'package:touski/domain/services/tflite_service.dart';
import 'package:touski/presentation/app/app_setup.dart';

class AnalyseImageUsecase {
  final TfliteService tfliteService = locator<TfliteService>();

  AnalyseImageUsecase();

  Future<AnalysisResult> execute(Image image) async {
    const int inputSize = 640;

    final resized = img.copyResize(image, width: inputSize, height: inputSize);

    final List<Detection> detections = await tfliteService.processImage(resized, inputSize);

    final Set<String> detectedFoods = {};

    for(Detection d in detections) {
      final x1 = ((d.box.x) * inputSize).toInt();
      final y1 = ((d.box.y) * inputSize).toInt();
      final x2 = ((d.box.x + d.box.w* inputSize)).toInt();
      final y2 = ((d.box.y + d.box.h* inputSize)).toInt();

      img.drawRect(
        resized,
        x1: x1,
        y1: y1,
        x2: x2,
        y2: y2,
        color: d.color,
        thickness: 4,
      );

      img.drawString(
        resized,
        font: img.arial14,
        x: x1,
        y: (y1 + 16),
        '${d.foodClass.name} ${(d.score * 100).toStringAsFixed(1)}%',
        color: d.color,
      );

      detectedFoods.add(d.foodClass.name);
    }

    return AnalysisResult(
      image: resized,
      detectedFoods: detectedFoods.toList(),
    );
  }
}
