import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

enum LogType {
  verbose,
  debug,
  info,
  warning,
  error,
  fatal,
}

@LazySingleton()
class Log {
  final Logger logger;

  const Log(this.logger);

  void console(
    String message, {
    dynamic error,
    StackTrace? stackTrace,
    LogType type = LogType.debug,
  }) async {
    switch (type) {
      case LogType.verbose:
        logger.v(message, error, stackTrace);
        break;
      case LogType.debug:
        logger.d(message, error, stackTrace);
        break;
      case LogType.info:
        logger.d(message, error, stackTrace);
        break;
      case LogType.warning:
        logger.w(message, error, stackTrace);
        break;
      case LogType.error:
        logger.e(message, error, stackTrace);
        break;
      case LogType.fatal:
        logger.wtf(message, error, stackTrace);
        break;
    }
  }
}
