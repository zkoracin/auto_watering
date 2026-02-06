import 'package:flutter/material.dart';

enum StatusState { idle, testing, success, failure }

enum StatusContext { general, espConnection, espTime, pump }

extension StatusStateExtension on StatusState {
  String text(StatusContext context) {
    return switch ((this, context)) {
      (StatusState.testing, StatusContext.general) => 'Running...',
      (StatusState.testing, StatusContext.espConnection) => 'Testing...',
      (StatusState.testing, StatusContext.espTime) => 'Fetching...',
      (StatusState.testing, StatusContext.pump) => 'Testing connection...',

      (StatusState.success, StatusContext.general) => 'Test completed',
      (StatusState.success, StatusContext.espConnection) => 'ESP Connected',
      (StatusState.success, StatusContext.espTime) => 'ESP Time',
      (StatusState.success, StatusContext.pump) => 'Pump Connected',

      (StatusState.failure, StatusContext.general) => 'Test failed',
      (StatusState.failure, StatusContext.espConnection) =>
        'ESP connection failed',
      (StatusState.failure, StatusContext.espTime) =>
        'ESP Time fetching failed',
      (StatusState.failure, StatusContext.pump) => 'Pump connection Failed',

      (StatusState.idle, StatusContext.general) => 'Pump idle',
      (StatusState.idle, StatusContext.espConnection) => 'ESP Connection',
      (StatusState.idle, StatusContext.espTime) => 'ESP Time',
      (StatusState.idle, StatusContext.pump) => 'Pump Connection',
    };
  }

  Icon icon(ColorScheme colors, StatusContext context) {
    final (iconData, color) = switch (this) {
      StatusState.testing => (
        switch (context) {
          StatusContext.general => Icons.hourglass_top,
          StatusContext.espTime => Icons.schedule,
          StatusContext.espConnection => Icons.wifi,
          StatusContext.pump => Icons.hourglass_top,
        },
        colors.onSurfaceVariant,
      ),
      StatusState.success => (
        context == StatusContext.espTime
            ? Icons.access_time
            : Icons.check_circle,
        colors.primary,
      ),
      StatusState.failure => (Icons.error, colors.error),
      StatusState.idle => (
        switch (context) {
          StatusContext.espTime => Icons.schedule,
          StatusContext.espConnection => Icons.wifi,
          StatusContext.general => Icons.hourglass_bottom,
          StatusContext.pump => Icons.wifi,
        },
        colors.onSurface,
      ),
    };

    return Icon(iconData, color: color);
  }
}
