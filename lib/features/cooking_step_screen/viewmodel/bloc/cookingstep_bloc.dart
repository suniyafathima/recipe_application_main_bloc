import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cookingstep_event.dart';
part 'cookingstep_state.dart';

class CookingStepBloc extends Bloc<CookingStepEvent, CookingStepState> {
  final List<Map<String, dynamic>> steps;
  Timer? timer;

  CookingStepBloc(this.steps)
      : super(CookingStepState(
          currentStep: 0,
          secondsRemaining: steps[0]['duration'],
          isPaused: false,
          isCompleted: false,
        )) {
    on<StartCooking>(_onStart);
    on<Tick>(_onTick);
    on<PauseResumeCooking>(_onPauseResume);
    on<ResetStep>(_onReset);
    on<NextStep>(_onNext);
    on<PreviousStep>(_onPrevious);

    add(StartCooking());
  }

  void _onStart(StartCooking event, Emitter<CookingStepState> emit) {
    _startTimer();
  }

  void _onTick(Tick event, Emitter<CookingStepState> emit) {
    if (!state.isPaused) {
      final newTime = state.secondsRemaining - 1;
      if (newTime <= 0) {
        timer?.cancel();
        emit(state.copyWith(
          secondsRemaining: 0,
          isCompleted: state.currentStep == steps.length - 1,
        ));
      } else {
        emit(state.copyWith(secondsRemaining: newTime));
      }
    }
  }

  void _onPauseResume(PauseResumeCooking event, Emitter<CookingStepState> emit) {
    emit(state.copyWith(isPaused: !state.isPaused));
  }

  void _onReset(ResetStep event, Emitter<CookingStepState> emit) {
    timer?.cancel();
    emit(state.copyWith(
      secondsRemaining: steps[state.currentStep]['duration'],
      isPaused: false,
    ));
    _startTimer();
  }

  void _onNext(NextStep event, Emitter<CookingStepState> emit) {
    if (state.currentStep < steps.length - 1) {
      timer?.cancel();
      final next = state.currentStep + 1;
      emit(CookingStepState(
        currentStep: next,
        secondsRemaining: steps[next]['duration'],
        isPaused: false,
        isCompleted: false,
      ));
      _startTimer();
    }
  }

  void _onPrevious(PreviousStep event, Emitter<CookingStepState> emit) {
    if (state.currentStep > 0) {
      timer?.cancel();
      final prev = state.currentStep - 1;
      emit(CookingStepState(
        currentStep: prev,
        secondsRemaining: steps[prev]['duration'],
        isPaused: false,
        isCompleted: false,
      ));
      _startTimer();
    }
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => add(Tick()));
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
