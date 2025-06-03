import 'package:flutter/material.dart';

@immutable
sealed class BottomNavEvent {}

final class BottomNavItemSelected extends BottomNavEvent {
  final int index;
  BottomNavItemSelected(this.index);
}
