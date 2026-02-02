import 'package:flutter/material.dart';

enum EspConnectionState { idle, testing, success, failure }

extension EspConnectionStateExtension on EspConnectionState {
  String get buttonText {
    switch (this) {
      case EspConnectionState.testing:
        return 'Testing connection...';
      case EspConnectionState.success:
        return 'ESP Connected';
      case EspConnectionState.failure:
        return 'Connection Failed';
      case EspConnectionState.idle:
        return 'ESP Connection';
    }
  }

  Icon icon(ColorScheme colors) {
    switch (this) {
      case EspConnectionState.success:
        return Icon(Icons.check_circle, color: colors.primary);
      case EspConnectionState.failure:
        return Icon(Icons.error, color: colors.error);
      default:
        return Icon(Icons.wifi, color: colors.onSurface);
    }
  }
}
