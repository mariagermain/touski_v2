import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import "package:stacked_services/stacked_services.dart";
import 'package:touski/domain/services/tflite_service.dart';
import 'package:touski/domain/usecases/analyse_image_usecase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:touski/domain/usecases/get_recipe_usecase.dart';
import 'package:touski/infra/repositories/openai_repository.dart';

GetIt locator = GetIt.instance;

class AppSetup {
  static Future<void> setupLocator() async {
    await dotenv.load(fileName: "lib/.env");

    await _registerServices();
    _registerUseCases();
  }

  static Future<void> _registerServices() async {
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => DialogService());
    locator.registerLazySingleton(() => http.Client()); 
    locator.registerLazySingleton(() => FlutterSecureStorage());

    String apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
    locator.registerLazySingleton<OpenAIRepository>(() => OpenAIRepository(httpClient: http.Client(), apiKey: apiKey));

    locator.registerSingletonAsync<TfliteService>(() async {
      final service = TfliteService();
      await service.loadModel();
      return service;
    });
  }

  static void _registerUseCases() {
    locator.registerLazySingleton<AnalyseImageUsecase>(() => AnalyseImageUsecase());
    locator.registerLazySingleton<GetRecipeUsecase>(() => GetRecipeUsecase(openaiRepository: locator<OpenAIRepository>()));
  }
}