import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_navbar_event.dart';
import 'bottom_navbar_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavInitial()) {
    on<BottomNavItemSelected>((event, emit) {
      // Emit a state carrying the newly selected index
      emit(BottomNavIndexChanged(event.index));
    });
  }
}
