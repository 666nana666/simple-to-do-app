import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

// General failures
class NetworkFailure extends Failure {
  final String message;

  NetworkFailure({
    this.message = 'Seems you have connection issue',
  });

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  final String? message;

  ServerFailure({this.message = 'Server Error'});
  // TODO: Update server error message

  @override
  List<Object> get props => [message!];
}

class CacheFailure extends Failure {
  @override
  List<Object> get props => [];
}