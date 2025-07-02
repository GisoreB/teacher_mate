// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allClassesHash() => r'f18e4f7173089506506c9bd3c9f7060fba48d4e6';

/// See also [allClasses].
@ProviderFor(allClasses)
final allClassesProvider = AutoDisposeStreamProvider<List<Class>>.internal(
  allClasses,
  name: r'allClassesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allClassesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllClassesRef = AutoDisposeStreamProviderRef<List<Class>>;
String _$singleClassHash() => r'3357b4b64190aaa6a36b644257735f165df3fb6f';

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

/// See also [singleClass].
@ProviderFor(singleClass)
const singleClassProvider = SingleClassFamily();

/// See also [singleClass].
class SingleClassFamily extends Family<AsyncValue<Class>> {
  /// See also [singleClass].
  const SingleClassFamily();

  /// See also [singleClass].
  SingleClassProvider call(int classId) {
    return SingleClassProvider(classId);
  }

  @override
  SingleClassProvider getProviderOverride(
    covariant SingleClassProvider provider,
  ) {
    return call(provider.classId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'singleClassProvider';
}

/// See also [singleClass].
class SingleClassProvider extends AutoDisposeStreamProvider<Class> {
  /// See also [singleClass].
  SingleClassProvider(int classId)
    : this._internal(
        (ref) => singleClass(ref as SingleClassRef, classId),
        from: singleClassProvider,
        name: r'singleClassProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$singleClassHash,
        dependencies: SingleClassFamily._dependencies,
        allTransitiveDependencies: SingleClassFamily._allTransitiveDependencies,
        classId: classId,
      );

  SingleClassProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.classId,
  }) : super.internal();

  final int classId;

  @override
  Override overrideWith(
    Stream<Class> Function(SingleClassRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SingleClassProvider._internal(
        (ref) => create(ref as SingleClassRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        classId: classId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Class> createElement() {
    return _SingleClassProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleClassProvider && other.classId == classId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, classId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SingleClassRef on AutoDisposeStreamProviderRef<Class> {
  /// The parameter `classId` of this provider.
  int get classId;
}

class _SingleClassProviderElement
    extends AutoDisposeStreamProviderElement<Class>
    with SingleClassRef {
  _SingleClassProviderElement(super.provider);

  @override
  int get classId => (origin as SingleClassProvider).classId;
}

String _$classRepositoryHash() => r'37fd680abf7b8de7461a561d56313bcf9e9b6b76';

/// See also [ClassRepository].
@ProviderFor(ClassRepository)
final classRepositoryProvider =
    AutoDisposeNotifierProvider<ClassRepository, AppDatabase>.internal(
      ClassRepository.new,
      name: r'classRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$classRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ClassRepository = AutoDisposeNotifier<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
