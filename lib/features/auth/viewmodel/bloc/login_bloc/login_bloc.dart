import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginInitial()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, errorMessage: null));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, errorMessage: null));
    });

    on<LoginSubmitted>((event, emit) async {
      if (state.email.isEmpty || state.password.isEmpty) {
        emit(state.copyWith(errorMessage: "Email and password cannot be empty"));
        return;
      }

      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(state.email)) {
        emit(state.copyWith(errorMessage: "Invalid email format"));
        return;
      }

      emit(state.copyWith(isSubmitting: true, errorMessage: null));

      await Future.delayed(const Duration(seconds: 2));

      if (state.password.length >= 6) {
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } else {
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: false,
          errorMessage: "Invalid credentials",
        ));
      }
    });
  }
}

