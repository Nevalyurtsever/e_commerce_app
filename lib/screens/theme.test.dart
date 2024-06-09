import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';

class ThemeTestScreen extends StatelessWidget {
  const ThemeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'titleLarge ${context.theme.textTheme.titleMedium?.fontSize} ${context.theme.textTheme.titleMedium?.fontWeight}',
                style: context.theme.textTheme.titleLarge,
              ),
              const Divider(),
              Text(
                'titleMedium ${context.theme.textTheme.titleMedium?.fontSize} ${context.theme.textTheme.titleMedium?.fontWeight}',
                style: context.theme.textTheme.titleMedium,
              ),
              const Divider(),
              Text(
                'titleSmall ${context.theme.textTheme.titleSmall?.fontSize} ${context.theme.textTheme.titleSmall?.fontWeight}',
                style: context.theme.textTheme.titleSmall,
              ),
              const Divider(),
              Text(
                'bodyLarge ${context.theme.textTheme.bodyLarge?.fontSize} ${context.theme.textTheme.bodyLarge?.fontWeight}',
                style: context.theme.textTheme.bodyLarge,
              ),
              const Divider(),
              Text(
                'bodyMedium ${context.theme.textTheme.bodyMedium?.fontSize} ${context.theme.textTheme.bodyMedium?.fontWeight}',
                style: context.theme.textTheme.bodyMedium,
              ),
              const Divider(),
              Text(
                'bodySmall ${context.theme.textTheme.bodySmall?.fontSize} ${context.theme.textTheme.bodySmall?.fontWeight}',
                style: context.theme.textTheme.bodySmall,
              ),
              const Divider(),
              Text(
                'displayLarge ${context.theme.textTheme.displayLarge?.fontSize} ${context.theme.textTheme.displayLarge?.fontWeight}',
                style: context.theme.textTheme.displayLarge,
              ),
              const Divider(),
              Text(
                'displayMedium ${context.theme.textTheme.displayMedium?.fontSize} ${context.theme.textTheme.displayMedium?.fontWeight}',
                style: context.theme.textTheme.displayMedium,
              ),
              const Divider(),
              Text(
                'displaySmall ${context.theme.textTheme.displaySmall?.fontSize} ${context.theme.textTheme.displaySmall?.fontWeight}',
                style: context.theme.textTheme.displaySmall,
              ),
              const Divider(),
              Text(
                'headlineLarge ${context.theme.textTheme.headlineLarge?.fontSize} ${context.theme.textTheme.headlineLarge?.fontWeight}',
                style: context.theme.textTheme.headlineLarge,
              ),
              const Divider(),
              Text(
                'headlineMedium ${context.theme.textTheme.headlineMedium?.fontSize} ${context.theme.textTheme.headlineMedium?.fontWeight}',
                style: context.theme.textTheme.headlineMedium,
              ),
              const Divider(),
              Text(
                'headlineSmall ${context.theme.textTheme.headlineSmall?.fontSize} ${context.theme.textTheme.headlineSmall?.fontWeight}',
                style: context.theme.textTheme.headlineSmall,
              ),
              const Divider(),
              Text(
                'labelLarge ${context.theme.textTheme.labelLarge?.fontSize} ${context.theme.textTheme.labelLarge?.fontWeight}',
                style: context.theme.textTheme.labelLarge,
              ),
              const Divider(),
              Text(
                'labelMedium ${context.theme.textTheme.labelMedium?.fontSize} ${context.theme.textTheme.labelMedium?.fontWeight}',
                style: context.theme.textTheme.labelMedium,
              ),
              const Divider(),
              Text(
                'labelSmall ${context.theme.textTheme.labelSmall?.fontSize} ${context.theme.textTheme.labelSmall?.fontWeight}',
                style: context.theme.textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
