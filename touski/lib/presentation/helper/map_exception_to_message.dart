import 'package:easy_localization/easy_localization.dart';
import 'package:touski/domain/enum/error_status_code.dart';
import 'package:touski/domain/failures/http_response_failure.dart';
import 'package:touski/domain/failures/network_failure.dart';
import 'package:touski/domain/failures/openai_api_failure.dart';
import 'package:touski/generated/locale_keys.g.dart';

String mapExceptionToMessage(Exception exception) {
  if(exception is HttpResponseFailure) {
    return LocaleKeys.message_failure_http_response.tr();
  } else if (exception is NetworkFailure) {
    return LocaleKeys.message_failure_network.tr();
  } else if (exception is OpenaiApiFailure) {
    if (exception.errorStatusCode == ErrorStatusCode.BILLING_NOT_ACTIVE) {
      return LocaleKeys.message_failure_openai_billing_not_active.tr();
    }
    else if (exception.errorStatusCode == ErrorStatusCode.INVALID_API_KEY) {
      return LocaleKeys.message_failure_openai_invalid_api_key.tr();
    }
    return "Une erreur est survenue lors de l'appel à l'API d'OpenAI";
  } 
  else {
    return LocaleKeys.message_failure_othercase.tr();
  }
}