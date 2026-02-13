import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConfirmBtnState {
  static bool canConfirm(
    AsyncValue<dynamic> asyncState,
    dynamic draft,
    dynamic displayValue,
  ) {
    return !asyncState.hasError &&
        draft != null &&
        !asyncState.isLoading &&
        draft != displayValue;
  }
}
