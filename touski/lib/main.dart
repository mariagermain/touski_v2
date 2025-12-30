import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:touski/presentation/app/app.router.dart';
import 'package:touski/presentation/app/app_setup.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppSetup.setupLocator();
  await EasyLocalization.ensureInitialized();
  cameras = await availableCameras();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('fr', 'CA'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('fr', 'CA'),
      child: const MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // -- pour l'internationalisation -- //
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: Routes.homeView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
    );
  }
}