import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_application_main/features/list_screen/viewmodel/listt_event.dart';
import 'package:recipe_application_main/features/list_screen/viewmodel/listt_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(InitialState()) {
    on<LoadList>((event, emit) {
      emit(LoadedState(
        ingredients: event.ingredients,
        addedItems: [],
      ));
    });

    on<AddToList>((event, emit) {
      if (state is LoadedState) {
        final currentState = state as LoadedState;
        final updated = List<String>.from(currentState.addedItems)..add(event.newItem);
        emit(LoadedState(
          ingredients: currentState.ingredients,
          addedItems: updated,
        ));
      }
    });

    on<RemoveFromList>((event, emit) {
      if (state is LoadedState) {
        final currentState = state as LoadedState;
        final updated = List<String>.from(currentState.addedItems);
        if (event.index < updated.length) {
          updated.removeAt(event.index);
        }
        emit(LoadedState(
          ingredients: currentState.ingredients,
          addedItems: updated,
        ));
      }
    });

    on<ClearList>((event, emit) { 
      if (state is LoadedState) {
        final currentState = state as LoadedState;
        emit(LoadedState(
          ingredients: currentState.ingredients,
          addedItems: [],
        ));
      }
    });
  }
}
