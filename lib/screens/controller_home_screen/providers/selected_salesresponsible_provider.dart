import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/models/user/user.dart';
part 'selected_salesresponsible_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedSalseresponsibles extends _$SelectedSalseresponsibles {
  @override
  AppUser? build() {
    return null;
  }

  void setState(AppUser? v) {
    state = v;
  }
}
