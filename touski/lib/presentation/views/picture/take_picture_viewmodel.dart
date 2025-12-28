import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:touski/domain/entities/detection.dart';
import 'package:touski/domain/usecases/analyse_image_usecase.dart';
import 'package:touski/presentation/app/app.router.dart';
import 'package:touski/presentation/app/app_setup.dart';

class TakePictureViewModel extends BaseViewModel{
  final _navigationService = locator<NavigationService>();
  final _analyseImageUsecase = locator<AnalyseImageUsecase>();

  final ImagePicker _picker = ImagePicker();

  bool pictureTaken = false;
  Image? _image;
  Set<String>? _detectedFoods;

  Set<String>? get detectedFoods => _detectedFoods;
  Uint8List? get image => _image != null ? Uint8List.fromList(img.encodeJpg(_image!)) : null;
  
  Future<void> importPicture() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (picked == null) return;

    final bytes = await picked.readAsBytes();
    _image = img.decodeImage(bytes);
  

    await analysePicture();
    notifyListeners();
  }

  Future<void> setTakenPicture(XFile imageFile) async {
    final bytes = await imageFile.readAsBytes();
    _image = img.decodeImage(bytes);

    await analysePicture();
    notifyListeners();
  }

Future<void> analysePicture() async {
  if (_image == null) return;

  final List<Detection> result = await _analyseImageUsecase.execute(_image!);

  for(Detection r in result){
    _detectedFoods?.add(r.foodClass.name);
  }

  notifyListeners();
}

  void navigateToRecipeView(){
    _navigationService.navigateTo(Routes.recipeView);
  }
  void retakePicture(){
    _image = null;
    notifyListeners();
  }
}