import 'package:image/image.dart';
import 'package:touski/domain/entities/detection.dart';
import 'package:touski/domain/services/tflite_service.dart';
import 'package:touski/presentation/app/app_setup.dart';

class AnalyseImageUsecase {
  final TfliteService tfliteService = locator<TfliteService>();

  AnalyseImageUsecase();

  Future<List<Detection>> execute(Image image) async {
    return tfliteService.processImage(image);
  }

}
