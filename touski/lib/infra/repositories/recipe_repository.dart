import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:touski/domain/failures/base_failure.dart';
import 'package:touski/domain/failures/http_response_failure.dart';
import 'package:touski/domain/failures/network_failure.dart';
import 'package:touski/infra/openai_api_routes.dart';

class RecipeRepository {
  final http.Client httpClient;

  const RecipeRepository({required this.httpClient});

  Future<String> getRevolvairAirQuality() async {
    return _getRecipe();
  }

  Future<String> _getRecipe() async {

    try {
      final url = Uri.parse(openaiApiRoute);
      final response = await httpClient.get(url);

      if(response.statusCode == 200) {
        Map<String, dynamic> iqaJson = jsonDecode(response.body);
        return iqaJson.toString();
      } else {
          throw HttpResponseFailure(message: 'Erreur de connexion. Code d\'état : ${response.statusCode}', context: '?');
      }

    } on BaseFailure {
      rethrow;
    } on SocketException catch (e) {
      throw NetworkFailure(message: 'Réseau indisponible. Vérifiez votre connexion internet.', context: e.toString());
    }
  }

}