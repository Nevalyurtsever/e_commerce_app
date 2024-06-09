import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/slide.dart';
import '../../../core/repositories/realtime_db_repository.dart';
part 'slides_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Slide>> slides(Ref ref) async {
  List<Slide> slides = await ref.read(realtimeDbRepositoryProvider).getSlides();
  slides.sort((a, b) => a.order.compareTo(b.order));
  return slides;
}
