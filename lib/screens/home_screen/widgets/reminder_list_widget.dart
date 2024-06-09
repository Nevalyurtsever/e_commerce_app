import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants.dart';
import '../../reminders_screen/providers/reminder_list_provider.dart';
import '../../reminders_screen/reminders_screen.dart';

class ReminderListWidget extends ConsumerWidget {
  const ReminderListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      return ref.watch(remindersProvider).when(
            data: (data) {
              if (data.isEmpty) {
                return const SizedBox.shrink();
              }
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.theme.appColors.cardColor,
                  border:
                      Border.all(color: context.theme.appColors.borderColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                //height: data.isEmpty ? 0 : constraints.maxWidth / 2,
                child: Column(
                  children: [
                    Text(
                      context.localizations!.reminders,
                      style: context.theme.appTextTheme.titleStyle
                          .copyWith(fontSize: 16),
                    ),
                    Column(
                      children: List.generate(
                        data.length,
                        (index) => ListTile(
                          onTap: () => context.push(RemindersScreen.routeName),
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
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: ListView.separated(
                    //     itemCount: data.length,
                    //     separatorBuilder: (context, index) => const Divider(),
                    //     itemBuilder: (context, index) => ListTile(
                    //       onTap: () => context.push(RemindersScreen.routeName),
                    //       title: Text(
                    //         data[index].title.toString(),
                    //       ),
                    //       subtitle: Text(
                    //         Constants.dateTimeFormat(
                    //             context.localizations!.localeName,
                    //             data[index].date),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
            error: (error, _) => Center(
              child: Text(error.toString()),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
    });
  }
}
