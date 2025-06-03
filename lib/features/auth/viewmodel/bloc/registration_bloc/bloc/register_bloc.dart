import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterNameChanged>((event, emit) {
      emit(state.copyWith(name: event.name, errorMessage: null));
    });

    on<RegisterEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, errorMessage: null));
    });

    on<RegisterPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, errorMessage: null));
    });

    on<RegisterSubmitted>((event, emit) async {
      if (state.name.isEmpty || state.email.isEmpty || state.password.isEmpty) {
        emit(state.copyWith(errorMessage: "All fields are required"));
        return;
      }

      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(state.email)) {
        emit(state.copyWith(errorMessage: "Invalid email format"));
        return;
      }

      emit(state.copyWith(isSubmitting: true, errorMessage: null));

      await Future.delayed(Duration(seconds: 2));

      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}
