import 'package:flutter/material.dart';

import '../../features/attention/presentation/attention_screen.dart';
import '../../features/deep_work/presentation/deep_work_screen.dart';
import '../../features/library/presentation/library_screen.dart';
import '../../features/reflection/presentation/reflection_screen.dart';
import '../../features/review/presentation/review_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/signal/presentation/signal_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  static const _screens = <Widget>[
    SignalScreen(),
    ReflectionScreen(),
    AttentionScreen(),
    DeepWorkScreen(),
    LibraryScreen(),
    ReviewScreen(),
    SettingsScreen(),
  ];

  static const _destinations = <NavigationDestination>[
    NavigationDestination(
      icon: Icon(Icons.wb_sunny_outlined),
      selectedIcon: Icon(Icons.wb_sunny),
      label: 'Signal',
    ),
    NavigationDestination(
      icon: Icon(Icons.edit_note_outlined),
      selectedIcon: Icon(Icons.edit_note),
      label: 'Reflect',
    ),
    NavigationDestination(
      icon: Icon(Icons.center_focus_weak),
      label: 'Attention',
    ),
    NavigationDestination(
      icon: Icon(Icons.hourglass_empty),
      label: 'Deep Work',
    ),
    NavigationDestination(
      icon: Icon(Icons.menu_book_outlined),
      label: 'Library',
    ),
    NavigationDestination(
      icon: Icon(Icons.calendar_view_week_outlined),
      label: 'Review',
    ),
    NavigationDestination(
      icon: Icon(Icons.tune),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: _destinations,
      ),
    );
  }
}
