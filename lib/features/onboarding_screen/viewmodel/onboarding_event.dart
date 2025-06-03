import 'package:flutter/foundation.dart';

@immutable
sealed class OnboardingEvent {}

class OnboardingPageChanged extends OnboardingEvent {
  final int page;
  OnboardingPageChanged(this.page);
}
