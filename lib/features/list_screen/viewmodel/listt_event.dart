sealed class ListEvent {
  const ListEvent();
}

class AddItem extends ListEvent {
  final String item;
  const AddItem(this.item);
}

class RemoveItem extends ListEvent {
  final int index;
  const RemoveItem(this.index);
}

class ClearAll extends ListEvent {
  const ClearAll();
}
