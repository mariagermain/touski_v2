import 'dart:convert';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'package:touski/domain/enum/error_status_code.dart';
import 'package:touski/domain/failures/base_failure.dart';
import 'package:touski/domain/failures/network_failure.dart';
import 'package:touski/domain/failures/openai_api_failure.dart';
import 'package:touski/generated/locale_keys.g.dart';

class OpenAIRepository {
  final openaiApiURI = "https://api.openai.com/v1/responses";
  final http.Client httpClient;
  final String apiKey;

  OpenAIRepository({required this.httpClient, required this.apiKey});

  Future<String> makeRequest(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse(openaiApiURI),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "gpt-4",
          "input": prompt,
        }),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final errorJson = decoded['error'];
        final apiType = errorJson['type'] as String? ?? 'unauthorized';
        final statusCode = parseErrorStatusCode(apiType);

        throw OpenaiApiFailure(
          message: 'OpenAI API error',
          errorStatusCode: statusCode,
        );
      }

      return decoded['output'].first['content'].first['text'].toString();

    } on BaseFailure {
      rethrow;
    } on SocketException catch (e) {
      throw NetworkFailure(message: LocaleKeys.message_failure_network.tr(), context: e.toString());
    }
  }

  ErrorStatusCode parseErrorStatusCode(String apiValue) {
    return ErrorStatusCode.values.firstWhere(
      (e) => e.value == apiValue,
      orElse: () => ErrorStatusCode.UNAUTHORIZED,
    );
  }

}