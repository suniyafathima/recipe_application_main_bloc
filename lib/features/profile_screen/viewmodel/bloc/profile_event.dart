part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class TogglePushNotificationEvent extends ProfileEvent {
  final bool isEnabled;
  TogglePushNotificationEvent(this.isEnabled);
}
