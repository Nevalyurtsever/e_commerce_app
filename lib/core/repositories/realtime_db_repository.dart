import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/slide.dart';
import '../services/fcm_service.dart';
import '../services/realtime_db_service.dart';

part 'realtime_db_repository.g.dart';

class RealtimeDbRepository {
  final Ref _ref;
  RealtimeDbRepository(this._ref);

  //////////////////////////////// -SLIDER API- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  Future<List<Slide>> getSlides() async {
    return await _ref.read(realtimeDbServiceServiceProvider).getSlides();
  }

  Future<void> saveFcmToken(String uid, String role) async {
    String? token = await _ref.read(fcmServiceProvider).getFcmToken();
    if (token != null) {
      _ref
          .read(realtimeDbServiceServiceProvider)
          .saveFcmToken(uid, token, role);
    }
    _ref.read(fcmServiceProvider).subscribeTopic(role);
  }

  //////////////////////////////// -SLIDER API- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  Future<Map<String, dynamic>> getCategories() async {
    return _ref.read(realtimeDbServiceServiceProvider).getCategories();
  }
}

@riverpod
RealtimeDbRepository realtimeDbRepository(ref) {
  return RealtimeDbRepository(ref);
}
