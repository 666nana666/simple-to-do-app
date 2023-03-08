import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@singleton
class Crashlytics {
  static final FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

  String get _logPrefix => 'Crashlytics: ';

  Future<void> initialize() async {
    if (kDebugMode) {
      await crashlytics.setCrashlyticsCollectionEnabled(false);
      log(
        '${_logPrefix}Disabled',
      );
    } else {
      await crashlytics.setCrashlyticsCollectionEnabled(true);
      log(
        '${_logPrefix}Enabled',
      );
    }

    if (crashlytics.isCrashlyticsCollectionEnabled) {
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    }
  }

  Future<void> setUserIdentifier(String phone) async {
    await crashlytics.setUserIdentifier(phone);
    log(
      '${_logPrefix}User identifier set to $phone',
    );
  }
}
