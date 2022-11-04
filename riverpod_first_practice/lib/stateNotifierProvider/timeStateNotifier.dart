// ignore: file_names
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timeProvider = StateNotifierProvider<MyTime, DateTime>((ref) => MyTime());

class MyTime extends StateNotifier<DateTime> {
  late final Timer _currentTimer;
  MyTime() : super(DateTime.now()) {
    _currentTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = DateTime.now();
    });
  }
  @override
  void dispose() {
    _currentTimer.cancel();
    super.dispose();
  }
}
