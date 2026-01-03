part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// 🔹 STATE AWAL
class AuthInitial extends AuthState {}

/// 🔹 SAAT LOGIN PROSES
class AuthLoading extends AuthState {}

/// 🔹 LOGIN BERHASIL
class AuthSuccess extends AuthState {
  final String role; // admin / user

  const AuthSuccess({required this.role});

  @override
  List<Object?> get props => [role];
}

/// 🔹 LOGIN GAGAL
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
