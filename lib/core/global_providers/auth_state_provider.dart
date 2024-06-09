import 'package:e_commerce_app/core/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/realtime_db_repository.dart';
import 'role_provider.dart';

part 'auth_state_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthState extends _$AuthState {
  AuthState() {
    listenUserChanges();
  }
  @override
  User? build() {
    state = null;
    return state;
  }

  listenUserChanges() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      state = event;
      if (event != null) {
        setRole();
      }
    });
  }

  void setRole() async {
    try {
      IdTokenResult? token = await state!.getIdTokenResult(true);
      ref.read(roleStateProvider.notifier).setRole(token.claims?['role']);
      saveFcmToken(token.claims?['role']);
    } on FirebaseException catch (e) {
      if (e.code == "no-such-provider") {
        signOut();
      }
    }
  }

  void signOut() {
    ref.read(authRepositoryProvider).signOut();
  }

  void updateLanguage(String language) {
    ref.read(authRepositoryProvider).updateLanguage(language);
  }

  void saveFcmToken(String? role) {
    if (role != null) {
      ref.read(realtimeDbRepositoryProvider).saveFcmToken(state!.uid, role);
    }
  }
}
