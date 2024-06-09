import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/global_providers/auth_state_provider.dart';
import '../../core/repositories/firestore_repository.dart';
import 'new_reminder_screen.dart';
import 'providers/reminder_list_provider.dart';
import 'widgets/order_notes_widget.dart';

class RemindersScreen extends ConsumerWidget {
  static String routeName = "/reminders";

  const RemindersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.localizations!.reminders),
        ),
        body: Column(
          children: [
            TabBar(tabs: [
              Tab(text: context.localizations!.reminders),
              Tab(text: context.localizations!.order_notes)
            ]),
            Expanded(
              child: TabBarView(children: [
                ref.watch(remindersProvider).when(
                      data: (data) {
                        return ListView.separated(
                          itemCount: data.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) => ListTile(
                            isThreeLine: true,
                            title: Text(
                              data[index].title.toString(),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[index].description),
                                Text(
                                  Constants.dateTimeFormat(
                                      context.localizations!.localeName,
                                      data[index].date),
                                ),
                              ],
                            ),
                            trailing: IconButton.filled(
                              onPressed: () async {
                                await ref
                                    .read(firestoreRepositoryProvider)
                                    .deleteReminder(
                                        ref.read(authStateProvider)!.uid,
                                        data[index].id);

                                ref.invalidate(remindersProvider);
                              },
                              icon: Icon(Icons.delete,
                                  color: context.theme.appColors.danger),
                            ),
                          ),
                        );
                      },
                      error: (error, _) => Center(
                        child: Text(error.toString()),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                const OrderNotesWidget()
              ]),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(NewReminderScreen.routeName),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
