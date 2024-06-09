import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/global_providers/auth_state_provider.dart';
import '../../../core/models/reminder.dart';
import '../../../core/repositories/firestore_repository.dart';
part 'new_reminder.g.dart';

@riverpod
class NewReminder extends _$NewReminder {
  @override
  void build() {}

  Future<bool> newReminder(Reminder reminder, BuildContext context) async {
    try {
      await ref
          .read(firestoreRepositoryProvider)
          .addNewReminder(reminder, ref.read(authStateProvider)!.uid);
      return true;
    } on FirebaseException catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: const Text('Error'),
            content: Text(e.message.toString()),
          ),
        );
      }
      return false;
    }
  }
}
