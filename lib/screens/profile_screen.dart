import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/global_providers/auth_state_provider.dart';
import '../core/global_providers/role_provider.dart';
import '../core/global_providers/settings_box.dart';
import '../core/global_providers/user_state_provider.dart';
import 'customers_screen/customers_screen.dart';
import 'edit_profile_screen.dart';
import 'reminders_screen/reminders_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool bussy = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? theme = ref.read(settingsBoxProvider).get('theme');

    final user = ref.watch(userStateProvider);

    if (user == null) return const SizedBox.shrink();

    if (bussy) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: user.photoURL != null
                            ? CachedNetworkImageProvider(user.photoURL!)
                            : null,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // name
                            Text(
                              user.createFullName(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // email
                            Text(
                              user.email,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Divider(height: 1),
                  ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(context.localizations!.my_details),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => context.push(EditProfileScreen.routeName)),
                  if (ref.read(roleStateProvider) == Role.salesResponsible)
                    const Divider(),
                  if (ref.read(roleStateProvider) == Role.salesResponsible)
                    ListTile(
                      leading: const Icon(Icons.circle_notifications),
                      title: Text(context.localizations!.reminders),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.push(RemindersScreen.routeName);
                      },
                    ),
                  const Divider(),
                  if (ref.read(roleStateProvider) == Role.salesResponsible)
                    ListTile(
                      leading: const Icon(Icons.groups),
                      title: Text(context.localizations!.customers),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.push(CustomersScreen.routeName);
                      },
                    ),
                  if (ref.read(roleStateProvider) == Role.salesResponsible)
                    const Divider(),
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
                    leading: Icon(
                        theme == "dark" ? Icons.dark_mode : Icons.light_mode),
                    title: Text(context.localizations!.theme),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => showThemeSettings(context),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: Text(context.localizations!.log_out),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    tileColor: context.theme.appColors.danger,
                    onTap: () {
                      ref.read(authStateProvider.notifier).signOut();
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ),
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
