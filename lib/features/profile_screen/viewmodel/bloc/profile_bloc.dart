import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState(pushNotifications: true)) {
    on<TogglePushNotificationEvent>((event, emit) {
      emit(state.copyWith(pushNotifications: event.isEnabled));
    });
  }
}
