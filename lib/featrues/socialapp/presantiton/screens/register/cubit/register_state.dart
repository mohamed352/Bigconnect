part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterScsuflly extends RegisterState {}

class RegisterError extends RegisterState {
  final String error;

  RegisterError(this.error);
}

class RegisterChangeIcon extends RegisterState {}

class RegisterCeratUserScsuflly extends RegisterState {
  final String uid;
  RegisterCeratUserScsuflly(this.uid);
}

class RegisterCeratUserError extends RegisterState {
  final String error;

  RegisterCeratUserError(this.error);
}
