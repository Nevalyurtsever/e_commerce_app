import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scroll_controller_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductListOffset extends _$ProductListOffset {
  @override
  double build() {
    return 0;
  }

  updateState(double offset) {
    state = offset;
  }
}
