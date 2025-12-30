import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:touski/domain/entities/analysis_result.dart';
import 'package:touski/domain/usecases/analyse_image_usecase.dart';
import 'package:touski/presentation/app/app.router.dart';
import 'package:touski/presentation/app/app_setup.dart';

class TakePictureViewModel extends BaseViewModel{
  final _navigationService = locator<NavigationService>();
  final _analyseImageUsecase = locator<AnalyseImageUsecase>();

  final _picker = ImagePicker();

  Image? _image;
  List<String>? _detectedFoods;

  List<String>? get detectedFoods => _detectedFoods;
  Uint8List? get image => _image != null ? Uint8List.fromList(img.encodeJpg(_image!)) : null;
  
  Future<void> importPicture() async {
    setBusy(true);
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    _image = img.decodeImage(bytes);

    await processImage();
    setBusy(false);
    notifyListeners();
  }

  Future<void> setTakenPicture(XFile imageFile) async {
    setBusy(true);
    final bytes = await imageFile.readAsBytes();
    _image = img.decodeImage(bytes);

    await processImage();
    setBusy(false);
    notifyListeners();
  }

  Future<void> processImage() async {
    if (_image == null) return;

    final AnalysisResult result = await _analyseImageUsecase.execute(_image!);
    _image = result.image;
    _detectedFoods = result.detectedFoods;

    notifyListeners();
  }

  void retakePicture(){
    _image = null;
    notifyListeners();
  }

  void navigateToRecipeView(){
    _navigationService.navigateToRecipeView(
      detectedFoods: detectedFoods!
    );
  }
}