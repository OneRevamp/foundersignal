import 'package:flutter/material.dart';

import 'core/navigation/app_shell.dart';
import 'core/theme/app_theme.dart';

class FounderSignalApp extends StatelessWidget {
  const FounderSignalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Founder Signal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const AppShell(),
    );
  }
}
