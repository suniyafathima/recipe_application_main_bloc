import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/list_screen/viewmodel/listt_event.dart';
import 'package:recipe_application_main/features/list_screen/viewmodel/listt_state.dart';

class ListtBloc extends Bloc<ListEvent, ListState> {
  ListtBloc() : super(const ListInitial()) {
    final List<String> _items = [];

    on<AddItem>((event, emit) {
      _items.add(event.item);
      emit(ListUpdated(List.from(_items)));
    });

    on<RemoveItem>((event, emit) {
      if (event.index >= 0 && event.index < _items.length) {
        _items.removeAt(event.index);
        emit(ListUpdated(List.from(_items)));
      }
    });

    on<ClearAll>((event, emit) {
      _items.clear();
      emit(ListUpdated(List.from(_items)));
    });
  }
}
