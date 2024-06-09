import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/app_router.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('settings').listenable(),
        builder: (context, Box box, _) {
          var languageCode = box.get('language');
          var themeSettings = box.get('theme');

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: "E commerce app",
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode:
                themeSettings == 'light' ? ThemeMode.light : ThemeMode.dark,
            routerConfig: ref.read(goRouterProvider),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: languageCode == null
                ? const Locale('nl')
                : Locale(languageCode),
          );
        });
  }
}
