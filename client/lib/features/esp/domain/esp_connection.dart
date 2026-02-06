import 'package:flutter/material.dart';

enum EspConnectionState { idle, testing, success, failure }

enum EspUiContext { status, time }

extension EspConnectionStateExtension on EspConnectionState {
  String text(EspUiContext context) {
    switch (this) {
      case EspConnectionState.testing:
        return context == EspUiContext.status
            ? 'Testing connection...'
            : 'Fetching time...';

      case EspConnectionState.success:
        return context == EspUiContext.status ? 'ESP Connected' : 'ESP Time';

      case EspConnectionState.failure:
        return context == EspUiContext.status
            ? 'Connection Failed'
            : 'Fetching failed';

      case EspConnectionState.idle:
        return context == EspUiContext.status ? 'ESP Connection' : 'ESP Time';
    }
  }

  Icon icon(ColorScheme colors, EspUiContext context) {
    switch (this) {
      case EspConnectionState.testing:
        return Icon(
          context == EspUiContext.status ? Icons.wifi : Icons.schedule,
          color: colors.onSurface,
        );

      case EspConnectionState.success:
        return Icon(
          context == EspUiContext.status
              ? Icons.check_circle
              : Icons.access_time,
          color: colors.primary,
        );

      case EspConnectionState.failure:
        return Icon(Icons.error, color: colors.error);

      case EspConnectionState.idle:
        return Icon(
          context == EspUiContext.status ? Icons.wifi : Icons.schedule,
          color: colors.onSurface,
        );
    }
  }
}
