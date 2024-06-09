import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../services/storage_service.dart';

part 'storage_repository.g.dart';

class StorageRepository {
  final Ref _ref;
  StorageRepository(this._ref);

  Future<String?> uploadProfilePhoto(String uid, String path) async {
    String? url =
        await _ref.read(storageServiceProvider).uploadProfilePhoto(uid, path);

    if (url != null) {
      await _ref.read(authServiceProvider).updateProfilePhoto(url);
      await _ref.read(firestoreServiceProvider).updateProfilePhoto(uid, url);
    }
    return url;
  }
}

@riverpod
StorageRepository storageRepository(ref) {
  return StorageRepository(ref);
}
