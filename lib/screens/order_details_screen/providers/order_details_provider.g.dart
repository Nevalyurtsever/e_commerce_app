// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderDetailsHash() => r'db53d6053a2124627d78734836d9a278d288366a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [orderDetails].
@ProviderFor(orderDetails)
const orderDetailsProvider = OrderDetailsFamily();

/// See also [orderDetails].
class OrderDetailsFamily extends Family<AsyncValue<OrderModel?>> {
  /// See also [orderDetails].
  const OrderDetailsFamily();

  /// See also [orderDetails].
  OrderDetailsProvider call(
    String id,
  ) {
    return OrderDetailsProvider(
      id,
    );
  }

  @override
  OrderDetailsProvider getProviderOverride(
    covariant OrderDetailsProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'orderDetailsProvider';
}

/// See also [orderDetails].
class OrderDetailsProvider extends AutoDisposeFutureProvider<OrderModel?> {
  /// See also [orderDetails].
  OrderDetailsProvider(
    String id,
  ) : this._internal(
          (ref) => orderDetails(
            ref as OrderDetailsRef,
            id,
          ),
          from: orderDetailsProvider,
          name: r'orderDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderDetailsHash,
          dependencies: OrderDetailsFamily._dependencies,
          allTransitiveDependencies:
              OrderDetailsFamily._allTransitiveDependencies,
          id: id,
        );

  OrderDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<OrderModel?> Function(OrderDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OrderDetailsProvider._internal(
        (ref) => create(ref as OrderDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OrderModel?> createElement() {
    return _OrderDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderDetailsProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrderDetailsRef on AutoDisposeFutureProviderRef<OrderModel?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _OrderDetailsProviderElement
    extends AutoDisposeFutureProviderElement<OrderModel?> with OrderDetailsRef {
  _OrderDetailsProviderElement(super.provider);

  @override
  String get id => (origin as OrderDetailsProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
