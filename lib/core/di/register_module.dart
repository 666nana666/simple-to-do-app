import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../log/filter/release_log_filter.dart';
import '../log/printer/simple_log_printer.dart';

@module
abstract class RegisterModule {
  Logger get logger => Logger(
        printer: SimpleLogPrinter(),
        filter: ReleaseLogFilter(),
      );
}
