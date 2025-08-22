import 'package:lavagem_app/data/enum/enum_type_error.dart';

class AppError {
  final String message;
  final String className;
  final ErrorType type;
  final StackTrace stackTrace;
  final Map<String, dynamic>? additionalData;
  final Exception? originalException;
  final DateTime timestamp;

  const AppError({
    required this.message,
    required this.className,
    required this.type,
    required this.stackTrace,
    required this.timestamp,
    this.additionalData,
    this.originalException,
  });

  @override
  String toString() {
    return 'AppError(message: $message, className: $className, type: $type)';
  }
}