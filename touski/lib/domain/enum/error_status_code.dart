import 'package:easy_localization/easy_localization.dart';
import 'package:touski/generated/locale_keys.g.dart';

enum ErrorStatusCode {
  BILLING_NOT_ACTIVE('billing_not_active'),
  UNAUTHORIZED(''),
  INVALID_API_KEY('invalid_api_key');

  final String value;
  const ErrorStatusCode(this.value);
}