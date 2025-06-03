import 'package:flutter/material.dart';

@immutable
sealed class BottomNavState {
  final int selectedIndex;
  const BottomNavState(this.selectedIndex);
}

final class BottomNavInitial extends BottomNavState {
  const BottomNavInitial() : super(0);
}

final class BottomNavIndexChanged extends BottomNavState {
  const BottomNavIndexChanged(super.index);
}
