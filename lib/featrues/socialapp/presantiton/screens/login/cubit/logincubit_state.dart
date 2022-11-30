part of 'logincubit_cubit.dart';

abstract class LogincubitState {}

class LogincubitInitial extends LogincubitState {}

class LoginLoading extends LogincubitState {}

class LoginScsuflly extends LogincubitState {
  final String uid;
  

  LoginScsuflly(this.uid);
}

class LoginError extends LogincubitState {
  final String error;

  LoginError(this.error);
}

class LoginChangeIcon extends LogincubitState {}

class LoginRemmberMe extends LogincubitState {}

class LoginForgetPassordLoading extends LogincubitState {}

class LoginForgetPassordDone extends LogincubitState {}

class LoginForgetPassordError extends LogincubitState {
   final String error;

  LoginForgetPassordError(this.error);

}
