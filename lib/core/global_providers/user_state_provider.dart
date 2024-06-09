import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/user/user.dart';
import '../repositories/firestore_repository.dart';
import '../repositories/storage_repository.dart';

part 'user_state_provider.g.dart';

@Riverpod(keepAlive: true)
class UserState extends _$UserState {
  UserState() {
    listenUserChanges();
  }
  @override
  AppUser? build() {
    state = null;
    return state;
  }

  listenUserChanges() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        getUser(event.uid);
      } else {
        state = null;
      }
    });
  }

  getUser(String uid) async {
    state = await ref.read(firestoreRepositoryProvider).getUser(uid);
  }

  Future<bool> updateUser(AppUser newUser, BuildContext context) async {
    try {
      await ref.read(firestoreRepositoryProvider).updateUser(newUser);
      state = newUser;
      return true;
    } on FirebaseException catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
            title: const Text("Error"),
            content: Text(e.message.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              )
            ],
          ),
        );
      }
      return false;
    }
  }

  Future<void> updateProfilePhoto(String path) async {
    try {
      String? url = await ref
          .read(storageRepositoryProvider)
          .uploadProfilePhoto(state!.uid, path);

      AppUser newUser = state!;
      state = null;
      state = newUser.copyWith(photoURL: url);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
  }
}
