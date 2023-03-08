import 'package:dartz/dartz.dart';

import '../di/service_locator.dart';
import '../error/failures.dart';

abstract class UseCase<T, P, R extends Object> {
  R get repo => getIt<R>();

  Future<Either<Failure, T>> call(P params);
}

class NoParams {}
