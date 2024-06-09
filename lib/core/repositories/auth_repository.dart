import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/auth_service.dart';

part 'auth_repository.g.dart';

class AuthRepository {
  final Ref _ref;
  AuthRepository(this._ref);

  void signOut() {
    _ref.read(authServiceProvider).signOut();
  }

  void updateLanguage(String language) {
    _ref.read(authServiceProvider).updateLanguage(language);
  }
}

@riverpod
AuthRepository authRepository(ref) {
  return AuthRepository(ref);
}
