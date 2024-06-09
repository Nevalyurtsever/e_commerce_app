import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/slide.dart';

part 'realtime_db_service.g.dart';

class RealtimeDbServiceService {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  RealtimeDbServiceService();

//////////////////////////////// -SLIDER API- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

  Future<List<Slide>> getSlides() async {
    List<Slide> slides = [];
    final snapshot = await ref
        .child('slides')
        .orderByChild("status")
        .equalTo("PUBLISHED")
        // .orderByChild('order')
        .get();

    if (snapshot.value != null) {
      Map<String, dynamic> values = json.decode(json.encode(snapshot.value));

      for (final value in values.values.toList()) {
        slides.add(Slide.fromJson(value));
      }
    }

    return slides;
  }

  Future<Map<String, dynamic>> getCategories() async {
    DataSnapshot data = await ref.child('categories').get();

    if (data.value != null) {
      return Map<String, dynamic>.from(data.value as Map);
    } else {
      return {};
    }
  }

  Future<void> favorite(List<String> productIds, String uid) async {
    await ref.child('favorites').child(uid).set(productIds);
  }

  Future<List<String>> getFavorites(String uid) async {
    List<String> ids = [];
    DataSnapshot data = await ref.child('favorites').child(uid).get();

    if (data.value != null) {
      for (var id in data.value as List) {
        ids.add(id);
      }
    }

    return ids;
  }

  void saveFcmToken(String uid, String token, String role) async {
    await ref.child("fcmTokens/$uid").set(token);
  }
}

@riverpod
RealtimeDbServiceService realtimeDbServiceService(ref) {
  return RealtimeDbServiceService();
}
