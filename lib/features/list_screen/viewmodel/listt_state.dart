sealed class ListState {
  const ListState();
}

class ListInitial extends ListState {
  const ListInitial();
}

class ListUpdated extends ListState {
  final List<String> items;
  const ListUpdated(this.items);
}
