import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/user/user.dart';
import '../../../core/repositories/firestore_repository.dart';
part 'salesresponsible_provider.g.dart';

@Riverpod(keepAlive: true)
class Salseresponsibles extends _$Salseresponsibles {
  @override
  List<AppUser> build() {
    getSalesresponsibles();
    return [];
  }

  Future<void> getSalesresponsibles() async {
    state = await ref.read(firestoreRepositoryProvider).getSalesresponsibles();
  }
}
