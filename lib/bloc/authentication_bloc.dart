import 'package:flutter_bloc/flutter_bloc.dart';

// Events
sealed class AuthenticationEvent {}

class LoginEvent extends AuthenticationEvent {}

class LogoutEvent extends AuthenticationEvent {}

// States
sealed class AuthenticationState {}

class AuthenticationLoggedIn extends AuthenticationState {}

class AuthenticationNotLoggedIn extends AuthenticationState {}

// Bloc
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationNotLoggedIn()) {
    on<LoginEvent>((event, emit) => emit(AuthenticationLoggedIn()));
    on<LogoutEvent>((event, emit) => emit(AuthenticationNotLoggedIn()));
  }
}
