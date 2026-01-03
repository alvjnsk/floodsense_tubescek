import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login(String email, String password) {
    emit(AuthLoading());

    Future.delayed(const Duration(seconds: 1), () {
      if (email == 'admin@flood.com' && password == 'admin123') {
        emit(const AuthSuccess(role: 'admin'));
      } else if (email == 'user@flood.com' && password == 'user123') {
        emit(const AuthSuccess(role: 'user'));
      } else {
        emit(const AuthError('Email atau password salah'));
      }
    });
  }

  void logout() {
    emit(AuthInitial());
  }
}
