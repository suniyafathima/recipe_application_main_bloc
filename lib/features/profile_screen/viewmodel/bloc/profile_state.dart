part of 'profile_bloc.dart';

final class ProfileState {
  final bool pushNotifications;
  const ProfileState({required this.pushNotifications});

  ProfileState copyWith({bool? pushNotifications}) {
    return ProfileState(
      pushNotifications: pushNotifications ?? this.pushNotifications,
    );
  }
}
