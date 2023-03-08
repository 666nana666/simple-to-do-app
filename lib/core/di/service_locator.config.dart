// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i5;
import 'package:simpletodoapp/core/di/register_module.dart' as _i10;
import 'package:simpletodoapp/core/firebase/crashlytics.dart' as _i4;
import 'package:simpletodoapp/core/log/log.dart' as _i9;
import 'package:simpletodoapp/core/messenger/messenger.dart' as _i6;
import 'package:simpletodoapp/core/navigator/navigation.dart' as _i7;
import 'package:simpletodoapp/core/network/network_module.dart' as _i8;
import 'package:simpletodoapp/features/auth/presentation/cubit/auth_cubit.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i3.AuthCubit>(() => _i3.AuthCubit());
  gh.singleton<_i4.Crashlytics>(_i4.Crashlytics());
  gh.factory<_i5.Logger>(() => registerModule.logger);
  gh.lazySingleton<_i6.MessengerService>(() => _i6.MessengerService());
  gh.lazySingleton<_i7.NavigationService>(() => _i7.NavigationService());
  gh.lazySingleton<_i8.NetworkModule>(() => _i8.NetworkModuleImpl());
  gh.lazySingleton<_i9.Log>(() => _i9.Log(get<_i5.Logger>()));
  return get;
}

class _$RegisterModule extends _i10.RegisterModule {}
