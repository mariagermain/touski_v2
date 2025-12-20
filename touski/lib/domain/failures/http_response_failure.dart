import 'base_failure.dart';

class HttpResponseFailure extends BaseFailure {
  HttpResponseFailure({super.context, super.message});

  @override
  String toString() {
    return 'HttpResponseFailure:{ message: $message, context: $context }';
  }
}