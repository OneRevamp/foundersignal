import 'package:flutter/material.dart';

class AttentionScreen extends StatelessWidget {
  const AttentionScreen({super.key});

  @override
  Widget build(BuildContext context) => const _FeaturePlaceholder(
        title: 'Attention',
        description: 'Understand where your attention goes, without judgment.',
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
