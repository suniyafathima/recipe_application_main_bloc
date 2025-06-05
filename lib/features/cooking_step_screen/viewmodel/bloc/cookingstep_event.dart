part of 'cookingstep_bloc.dart';

sealed class CookingStepEvent {}

class StartCooking extends CookingStepEvent {}

class Tick extends CookingStepEvent {}

class PauseResumeCooking extends CookingStepEvent {}

class ResetStep extends CookingStepEvent {}

class NextStep extends CookingStepEvent {}

class PreviousStep extends CookingStepEvent {}
