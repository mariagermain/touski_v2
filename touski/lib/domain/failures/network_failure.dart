import 'base_failure.dart';

class NetworkFailure extends BaseFailure {
  NetworkFailure({super.context, super.message});

  @override
  String toString() {
    return 'NetworkFailure:{ message: $message, context: $context }';
  }
}