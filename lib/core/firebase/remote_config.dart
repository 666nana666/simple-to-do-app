import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<FirebaseRemoteConfig> setupRemoteConfig() async {
  var remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.ensureInitialized();
  await remoteConfig.fetchAndActivate();
  return remoteConfig;
}
