import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/global_providers/auth_state_provider.dart';
import '../../../core/global_providers/customer_provider.dart';
import '../../../core/models/reminder.dart';
import '../../../core/repositories/firestore_repository.dart';
part 'reminder_list_provider.g.dart';

@riverpod
Future<List<Reminder>> reminders(Ref ref) async {
  final customer = ref.read(customerStateProvider);

  if (customer == null) {
    return [];
  } else {
    return await ref
        .read(firestoreRepositoryProvider)
        .getReminders(ref.read(authStateProvider)!.uid, customer.uid);
  }
}
