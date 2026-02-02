import 'package:client/pages/tabs_page.dart';
import 'package:client/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async  {
  await dotenv.load(fileName: '.env');
  runApp(const WateringApp());
}

class WateringApp extends StatelessWidget {
  const WateringApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      home: const TabsPage(),
    );
  }
}