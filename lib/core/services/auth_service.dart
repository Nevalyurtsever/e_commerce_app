import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthService {
  AuthService();

  final _auth = FirebaseAuth.instance;

  void signOut() {
    _auth.signOut();
  }

  void updateLanguage(String language) {
    _auth.setLanguageCode(language);
  }

  Future<void> updateUserName(userName) async {
    await _auth.currentUser?.updateDisplayName(userName);
  }

  Future<void> updateProfilePhoto(String url) async {
    await _auth.currentUser?.updatePhotoURL(url);
  }
}

@riverpod
AuthService authService(ref) {
  return AuthService();
}
