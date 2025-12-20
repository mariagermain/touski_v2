import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import "package:stacked_services/stacked_services.dart";
import 'package:touski/domain/services/tflite_service.dart';

GetIt locator = GetIt.instance;

class AppSetup {
  static Future<void> setupLocator() async {
    _registerServices();
    _registerUseCases();
  }

  static void _registerServices() {
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => DialogService());
    locator.registerLazySingleton(() => http.Client()); 
    locator.registerLazySingleton(() => FlutterSecureStorage());
    locator.registerLazySingleton(() => TfliteService());
    
    /*locator.registerLazySingleton<RecipeRepository>(
      () => RecipeRepository(httpClient: locator<http.Client>()));
    locator.registerLazySingleton<SecureStorageRepository>(
      () => SecureStorageRepository(secureStorage: locator<FlutterSecureStorage>()));*/
  }

  static void _registerUseCases() {
    /*locator.registerLazySingleton<GetRecipeUseCase>(
      () => GetRecipeUseCase(recipeRepository: locator<RecipeRepository>()));*/
  }
}