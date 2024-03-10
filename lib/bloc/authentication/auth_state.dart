import 'package:dartz/dartz.dart';

abstract class AuthState {}

class AuthInitiateState extends AuthState {}


class AuthLodingState extends AuthState {}

class AuthResponseState extends AuthState {
  Either<String, String> response;
  AuthResponseState(this.response);
}
