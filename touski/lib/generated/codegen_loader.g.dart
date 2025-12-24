// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _fr_CA = {
  "app": {
    "title": "Touski"
  },
  "home": {
    "welcome_message": "Page d'ouverture de l'application...",
    "start_button": "Commencer"
  },
  "title_web_page": {
    "picture": "Prendre une photo",
    "recipe": "Recette"
  },
  "message_failure": {
    "announcement": "Une erreur est survenue",
    "othercase": "Une erreur innattendue est survenue. Veuillez réessayer plus tard ou contacter quelqu'un si le problème survient une énième fois.",
    "http_response": "Erreur de connexion, veuillez réessayer plus tard.",
    "network": "Réseau indisponible. Vérifiez votre connexion internet.",
    "repository": "Une erreur inattendue est survenue lors de la requête à l'API dans le Repository."
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"fr_CA": _fr_CA};
}
