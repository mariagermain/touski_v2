import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:touski/domain/entities/analysis_result.dart';
import 'package:touski/domain/services/tflite_service.dart';
import 'package:touski/presentation/app/app.router.dart';
import 'package:touski/presentation/app/app_setup.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

class TakePictureViewModel extends BaseViewModel{
  final _navigationService = locator<NavigationService>();
  final _tfliteService = locator<TfliteService>();

  final ImagePicker _picker = ImagePicker();

  bool pictureTaken = false;
  File? _image;
  File? get image => _image;

  Future<void> importPicture() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (picked == null) return;

    _image = File(picked.path);
    notifyListeners();
  }

  void setTakenPicture(String path) {
    _image = File(path);
    analysePicture();
    notifyListeners();
  }
  void analysePicture() async {
    AnalysisResult result = await _tfliteService.analyzeImage(_image!);

    final annotatedBytes = img.encodePng(result.annotatedImage);

    await _image!.writeAsBytes(annotatedBytes);
  }
  void navigateToRecipeView(){
    _navigationService.navigateTo(Routes.recipeView);
  }
  void retakePicture(){
    _image = null;
    notifyListeners();
  }
}