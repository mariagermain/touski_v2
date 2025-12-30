import 'package:touski/domain/enum/error_status_code.dart';

import 'base_failure.dart';

class OpenaiApiFailure extends BaseFailure {
  final ErrorStatusCode errorStatusCode;
  OpenaiApiFailure({required super.message, required this.errorStatusCode});

  @override
  String toString() => 'OpenaiApiFailure(message: $message)';
}