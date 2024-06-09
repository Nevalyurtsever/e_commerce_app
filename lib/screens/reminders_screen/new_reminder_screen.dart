import 'package:e_commerce_app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants.dart';
import '../../core/global_providers/customer_provider.dart';
import '../../core/models/reminder.dart';
import 'providers/new_reminder.dart';
import 'providers/reminder_list_provider.dart';

class NewReminderScreen extends ConsumerStatefulWidget {
  static String routeName = "/new-reminder";

  const NewReminderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewReminderScreenState();
}

class _NewReminderScreenState extends ConsumerState<NewReminderScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  String? _title;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localizations!.new_reminder),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration:
                    InputDecoration(labelText: context.localizations!.title),
                onSaved: (v) => _title = v,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    labelText: context.localizations!.description),
                onSaved: (v) => _description = v,
              ),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () async {
                  DateTime? date = await showDateTimePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 600),
                    ),
                  );
                  if (date != null) {
                    _date = date;
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.event),
                label: Text(
                  Constants.dateTimeFormat(
                      context.localizations!.localeName, _date),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Reminder reminder = Reminder(
                        title: _title,
                        description: _description!,
                        date: _date,
                        market: ref.read(customerStateProvider)!.uid,
                        id: "id");

                    bool result = await ref
                        .read(newReminderProvider.notifier)
                        .newReminder(reminder, context);
                    if (result && mounted) {
                      ref.invalidate(remindersProvider);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog.adaptive(
                          title: Text(context.localizations!.success),
                          actions: [
                            ElevatedButton(
                              onPressed: () => context.go('/'),
                              child: const Text('Ok'),
                            )
                          ],
                        ),
                      ).then(
                        (value) => context.pop(),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.save),
                label: Text(context.localizations!.save),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> showDateTimePicker({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }
}
