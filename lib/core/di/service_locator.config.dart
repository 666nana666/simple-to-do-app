// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i7;
import 'package:simpletodoapp/core/di/register_module.dart' as _i17;
import 'package:simpletodoapp/core/firebase/crashlytics.dart' as _i3;
import 'package:simpletodoapp/core/log/log.dart' as _i16;
import 'package:simpletodoapp/core/messenger/messenger.dart' as _i9;
import 'package:simpletodoapp/core/navigator/navigation.dart' as _i10;
import 'package:simpletodoapp/core/network/network_module.dart' as _i11;
import 'package:simpletodoapp/features/auth/data/data_sources/firebase_auth_data_source.dart'
    as _i4;
import 'package:simpletodoapp/features/auth/data/repositories/firebase_auth_repository_impl.dart'
    as _i6;
import 'package:simpletodoapp/features/auth/domain/repositories/firebase_auth_repository.dart'
    as _i5;
import 'package:simpletodoapp/features/auth/domain/use_cases/login_user_use_case.dart'
    as _i8;
import 'package:simpletodoapp/features/auth/domain/use_cases/register_use_case.dart'
    as _i12;
import 'package:simpletodoapp/features/auth/domain/use_cases/sign_out_use_case.dart'
    as _i13;
import 'package:simpletodoapp/features/auth/presentation/cubit/auth_cubit.dart'
    as _i15;
import 'package:simpletodoapp/features/task/presentation/cubit/todo_cubit.dart'
    as _i14; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i3.Crashlytics>(_i3.Crashlytics());
  gh.lazySingleton<_i4.FirebaseAuthDataSource>(
      () => _i4.FirebaseAuthDataSourceImpl());
  gh.lazySingleton<_i5.FirebaseAuthRepository>(() =>
      _i6.FirebaseAuthRepositoryImpl(
          firebaseAuthDataSource: get<_i4.FirebaseAuthDataSource>()));
  gh.factory<_i7.Logger>(() => registerModule.logger);
  gh.lazySingleton<_i8.LoginUserUseCase>(() => _i8.LoginUserUseCase(
      firebaseAuthRepository: get<_i5.FirebaseAuthRepository>()));
  gh.lazySingleton<_i9.MessengerService>(() => _i9.MessengerService());
  gh.lazySingleton<_i10.NavigationService>(() => _i10.NavigationService());
  gh.lazySingleton<_i11.NetworkModule>(() => _i11.NetworkModuleImpl());
  gh.lazySingleton<_i12.RegisterUserUseCase>(() => _i12.RegisterUserUseCase(
      firebaseAuthRepository: get<_i5.FirebaseAuthRepository>()));
  gh.lazySingleton<_i13.SignOutUserUseCase>(() => _i13.SignOutUserUseCase(
      firebaseAuthRepository: get<_i5.FirebaseAuthRepository>()));
  gh.factory<_i14.TodoCubit>(() => _i14.TodoCubit());
  gh.factory<_i15.AuthCubit>(() => _i15.AuthCubit(
        loginUserUseCase: get<_i8.LoginUserUseCase>(),
        registerUserUseCase: get<_i12.RegisterUserUseCase>(),
      ));
  gh.lazySingleton<_i16.Log>(() => _i16.Log(get<_i7.Logger>()));
  return get;
}

class _$RegisterModule extends _i17.RegisterModule {}
