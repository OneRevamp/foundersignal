import 'package:flutter/material.dart';

class DeepWorkScreen extends StatelessWidget {
  const DeepWorkScreen({super.key});

  @override
  Widget build(BuildContext context) => const _FeaturePlaceholder(
        title: 'Deep Work',
        description: 'Create space for focused, meaningful work.',
      );
}

class _FeaturePlaceholder extends StatelessWidget {
  const _FeaturePlaceholder({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 12),
              Text(description, textAlign: TextAlign.center),
            ],
          ),
        ),
      );
}
