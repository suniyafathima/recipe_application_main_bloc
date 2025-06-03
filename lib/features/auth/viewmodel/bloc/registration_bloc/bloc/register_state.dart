part of 'register_bloc.dart';

@immutable
sealed class RegisterState {
  final String name;
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  const RegisterState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return RegisterInitial(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}

class RegisterInitial extends RegisterState {
  const RegisterInitial({
    super.name,
    super.email,
    super.password,
    super.isSubmitting,
    super.isSuccess,
    super.errorMessage,
  });
}
