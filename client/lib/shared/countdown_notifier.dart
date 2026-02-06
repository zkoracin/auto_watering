import 'dart:async';
import 'package:flutter_riverpod/legacy.dart';

class CountdownNotifier extends StateNotifier<int> {
  CountdownNotifier() : super(0);
  Timer? _timer;

  void start(int seconds) {
    _timer?.cancel();
    state = seconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state <= 1) {
        timer.cancel();
        state = 0;
      } else {
        state--;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final countdownProvider = StateNotifierProvider<CountdownNotifier, int>((ref) {
  return CountdownNotifier();
});
