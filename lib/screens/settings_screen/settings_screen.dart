import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/global_providers/auth_state_provider.dart';
import '../../core/global_providers/settings_box.dart';

class SettingsScreen extends ConsumerWidget {
  static String routeName = "/settings";

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? theme = ref.read(settingsBoxProvider).get('theme');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(context.localizations!.language),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showLanguageSettings(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.password),
            title: Text(context.localizations!.password),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showPasswordSettings(context),
          ),
          const Divider(),
          ListTile(
            leading: Icon(theme == "dark" ? Icons.dark_mode : Icons.light_mode),
            title: Text(context.localizations!.theme),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => showThemeSettings(context),
          ),
        ],
      ),
    );
  }

  showLanguageSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) => Consumer(builder: (context, ref, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.localizations!.select_a_language,
              style: context.theme.textTheme.titleMedium,
            ),
            const Divider(),
            const SizedBox(height: 15),
            ListTile(
              title: const Text('Nederlands'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ref.read(settingsBoxProvider).put('language', "nl");
                ref.read(authStateProvider.notifier).updateLanguage("nl");
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('English'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ref.read(settingsBoxProvider).put('language', "en");
                ref.read(authStateProvider.notifier).updateLanguage("en");
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Deutsch'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ref.read(settingsBoxProvider).put('language', "de");
                ref.read(authStateProvider.notifier).updateLanguage("de");
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Türkçe'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ref.read(settingsBoxProvider).put('language', "tr");
                ref.read(authStateProvider.notifier).updateLanguage("tr");
                Navigator.pop(context);
              },
            ),
          ],
        );
      }),
    );
  }

  showPasswordSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.localizations!.new_password),
            const SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                  labelText: context.localizations!.new_password),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text(context.localizations!.save),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  showThemeSettings(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) => Consumer(builder: (context, ref, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(context.localizations!.theme),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: Text(context.localizations!.dark_theme),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ref.read(settingsBoxProvider).put('theme', 'dark');
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: Text(context.localizations!.light_theme),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                ref.read(settingsBoxProvider).put('theme', 'light');
                Navigator.pop(context);
              },
            ),
          ],
        );
      }),
    );
  }
}
