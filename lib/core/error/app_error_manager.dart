import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:lavagem_app/core/theme/error/app_error.dart';
import 'package:lavagem_app/data/enum/enum_type_error.dart';

class AppErrorManager {
  static final AppErrorManager _instance = AppErrorManager._internal();
  factory AppErrorManager() => _instance;
  AppErrorManager._internal();

  void logError({
    required String message,
    required String className,
    required ErrorType type,
    StackTrace? stackTrace,
    Map<String, dynamic>? additionalData,
    Exception? originalException,
  }) {
    final error = AppError(
      message: message,
      className: className,
      type: type,
      stackTrace: stackTrace ?? StackTrace.current,
      additionalData: additionalData,
      originalException: originalException,
      timestamp: DateTime.now(),
    );

    _logToConsole(error);

    if (kDebugMode) {
      _logDetailedError(error);
    }
  }

  void _logToConsole(AppError error) {
    log(
      error.message,
      name: '${error.className} [${error.type.name.toUpperCase()}]',
      error: error.originalException,
      stackTrace: error.stackTrace,
    );
  }

  void _logDetailedError(AppError error) {
    print('\n===== ERRO DETALHADO =====');
    print('Timestamp: ${error.timestamp}');
    print('Classe: ${error.className}');
    print('Tipo: ${error.type.name.toUpperCase()}');
    print('Mensagem: ${error.message}');

    if (error.additionalData?.isNotEmpty ?? false) {
      print('Dados Adicionais: ${error.additionalData}');
    }

    if (error.originalException != null) {
      print('Exceção Original: ${error.originalException}');
    }

    print('Stack Trace:');
    print(error.stackTrace);
    print('=======================\n');
  }

  void logNetworkError({
    required String message,
    required String className,
    int? statusCode,
    String? endpoint,
    String? method,
    StackTrace? stackTrace,
    Exception? originalException,
  }) {
    logError(
      message: message,
      className: className,
      type: ErrorType.network,
      stackTrace: stackTrace,
      additionalData: {
        'statusCode': statusCode,
        'endpoint': endpoint,
        'method': method,
      },
      originalException: originalException,
    );
  }

  void logDatabaseError({
    required String message,
    required String className,
    String? query,
    String? table,
    StackTrace? stackTrace,
    Exception? originalException,
  }) {
    logError(
      message: message,
      className: className,
      type: ErrorType.database,
      stackTrace: stackTrace,
      additionalData: {
        'query': query,
        'table': table,
      },
      originalException: originalException,
    );
  }

  void logGeneralError({
    required String message,
    required String className,
    StackTrace? stackTrace,
    Exception? originalException,
  }) {
    logError(
      message: message,
      className: className,
      type: ErrorType.system,
      stackTrace: stackTrace,
      originalException: originalException,
    );
  }
  void logFirebaseError({
    required String message,
    required String className,
    StackTrace? stackTrace,
    Exception? originalException,
  }) {
    logError(
      message: message,
      className: className,
      type: ErrorType.system,
      stackTrace: stackTrace,
      originalException: originalException,
    );
  }
}
