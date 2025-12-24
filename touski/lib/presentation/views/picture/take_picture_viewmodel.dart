import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:touski/domain/entities/analysis_result.dart';
import 'package:touski/domain/usecases/analyse_image_usecase.dart';
import 'package:touski/presentation/app/app.router.dart';
import 'package:touski/presentation/app/app_setup.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

class TakePictureViewModel extends BaseViewModel{
  final _navigationService = locator<NavigationService>();
  final _analyseImageUsecase = locator<AnalyseImageUsecase>();

  final ImagePicker _picker = ImagePicker();

  bool pictureTaken = false;
  Uint8List? _imageBytes;
  List<String>? _detectedFoods;

  List<String>? get detectedFoods => _detectedFoods;
  Uint8List? get image => _imageBytes;

  Future<void> importPicture() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (picked == null) return;

    _imageBytes = await picked.readAsBytes();
    await analysePicture();
    notifyListeners();
  }

  Future<void> setTakenPicture(String imagePath) async {
    final file = XFile(imagePath);
    _imageBytes = await file.readAsBytes();
    await analysePicture();
    notifyListeners();
  }

Future<void> analysePicture() async {
  if (_imageBytes == null) return;

  final AnalysisResult result =
      await _analyseImageUsecase.execute(_imageBytes!);

  _detectedFoods = result.detectedFoods;
  _imageBytes = result.imageBytes;

  notifyListeners();
}

  void navigateToRecipeView(){
    _navigationService.navigateTo(Routes.recipeView);
  }
  void retakePicture(){
    _imageBytes = null;
    notifyListeners();
  }
  /*Float32List toFloat32List(Image image){
    const inputSize = 640;

    Float32List input = Float32List(inputSize * inputSize * 3);
    int index = 0;
    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final pixel = image.getPixel(x, y);
        input[index++] = pixel.r / 255.0;
        input[index++] = pixel.g / 255.0;
        input[index++] = pixel.b / 255.0;
      }
    }
    return input;
  }*/
}