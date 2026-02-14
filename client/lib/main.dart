import 'package:client/pages/tabs_page.dart';
import 'package:client/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    ProviderScope(
      retry: (retryCount, error) => null,
      child: const WateringApp(),
    ),
  );
}

class WateringApp extends StatelessWidget {
  const WateringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.lightTheme, home: const TabsPage());
  }
}
