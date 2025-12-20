import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:touski/presentation/app/app_setup.dart';
import 'package:touski/presentation/app/app.router.dart';

class HomeViewModel extends BaseViewModel{
  final _navigationService = locator<NavigationService>();

  
  void navigateToTakePictureView() {
    _navigationService.navigateTo(Routes.takePictureView);
  }
}