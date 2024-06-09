import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_service.g.dart';

class StorageService {
  final storage = FirebaseStorage.instance.ref();

  Future<String?> uploadOrderVideo(String orderId, String path) async {
    final imagesRef = storage.child('order-videos').child('$orderId.mp4');

    final metadata = SettableMetadata(
      contentType: 'video/mp4',
      customMetadata: {'picked-file-path': path},
    );

    if (kIsWeb) {
      await imagesRef.putData(await XFile(path).readAsBytes(), metadata);
    } else {
      await imagesRef.putFile(io.File(path), metadata);
    }

    return await imagesRef.getDownloadURL();
  }

  Future<String?> uploadProfilePhoto(String uid, String path) async {
    final imagesRef = storage.child('profile-pictures').child('$uid.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': path},
    );

    if (kIsWeb) {
      await imagesRef.putData(await XFile(path).readAsBytes(), metadata);
    } else {
      await imagesRef.putFile(io.File(path), metadata);
    }

    return await imagesRef.getDownloadURL();
  }

  Future<void> removeOrderVideo(String videoUrl) async {
    await storage.storage.refFromURL(videoUrl).delete();
  }
}

@riverpod
StorageService storageService(ref) {
  return StorageService();
}
