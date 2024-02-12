import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

class OfflineFailure extends Failure {
  const OfflineFailure({required super.statusCode, required super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.statusCode, required super.message});
}

class EmptyCacheFailure extends Failure {
  const EmptyCacheFailure({required super.statusCode, required super.message});
}
