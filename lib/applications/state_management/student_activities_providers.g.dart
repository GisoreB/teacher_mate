// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_activities_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activitiesForSessionHash() =>
    r'30adc75dbb30d300f12c5a34111f0c260094dc35';

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

/// See also [activitiesForSession].
@ProviderFor(activitiesForSession)
const activitiesForSessionProvider = ActivitiesForSessionFamily();

/// See also [activitiesForSession].
class ActivitiesForSessionFamily
    extends Family<AsyncValue<List<StudentActivity>>> {
  /// See also [activitiesForSession].
  const ActivitiesForSessionFamily();

  /// See also [activitiesForSession].
  ActivitiesForSessionProvider call(int sessionId) {
    return ActivitiesForSessionProvider(sessionId);
  }

  @override
  ActivitiesForSessionProvider getProviderOverride(
    covariant ActivitiesForSessionProvider provider,
  ) {
    return call(provider.sessionId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activitiesForSessionProvider';
}

/// See also [activitiesForSession].
class ActivitiesForSessionProvider
    extends AutoDisposeStreamProvider<List<StudentActivity>> {
  /// See also [activitiesForSession].
  ActivitiesForSessionProvider(int sessionId)
    : this._internal(
        (ref) =>
            activitiesForSession(ref as ActivitiesForSessionRef, sessionId),
        from: activitiesForSessionProvider,
        name: r'activitiesForSessionProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$activitiesForSessionHash,
        dependencies: ActivitiesForSessionFamily._dependencies,
        allTransitiveDependencies:
            ActivitiesForSessionFamily._allTransitiveDependencies,
        sessionId: sessionId,
      );

  ActivitiesForSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final int sessionId;

  @override
  Override overrideWith(
    Stream<List<StudentActivity>> Function(ActivitiesForSessionRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActivitiesForSessionProvider._internal(
        (ref) => create(ref as ActivitiesForSessionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<StudentActivity>> createElement() {
    return _ActivitiesForSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivitiesForSessionProvider &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ActivitiesForSessionRef
    on AutoDisposeStreamProviderRef<List<StudentActivity>> {
  /// The parameter `sessionId` of this provider.
  int get sessionId;
}

class _ActivitiesForSessionProviderElement
    extends AutoDisposeStreamProviderElement<List<StudentActivity>>
    with ActivitiesForSessionRef {
  _ActivitiesForSessionProviderElement(super.provider);

  @override
  int get sessionId => (origin as ActivitiesForSessionProvider).sessionId;
}

String _$activitiesForStudentHash() =>
    r'22ba9216b4594bee557397facfeb7d7848b55e8e';

/// See also [activitiesForStudent].
@ProviderFor(activitiesForStudent)
const activitiesForStudentProvider = ActivitiesForStudentFamily();

/// See also [activitiesForStudent].
class ActivitiesForStudentFamily
    extends Family<AsyncValue<List<StudentActivity>>> {
  /// See also [activitiesForStudent].
  const ActivitiesForStudentFamily();

  /// See also [activitiesForStudent].
  ActivitiesForStudentProvider call(int studentId) {
    return ActivitiesForStudentProvider(studentId);
  }

  @override
  ActivitiesForStudentProvider getProviderOverride(
    covariant ActivitiesForStudentProvider provider,
  ) {
    return call(provider.studentId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'activitiesForStudentProvider';
}

/// See also [activitiesForStudent].
class ActivitiesForStudentProvider
    extends AutoDisposeStreamProvider<List<StudentActivity>> {
  /// See also [activitiesForStudent].
  ActivitiesForStudentProvider(int studentId)
    : this._internal(
        (ref) =>
            activitiesForStudent(ref as ActivitiesForStudentRef, studentId),
        from: activitiesForStudentProvider,
        name: r'activitiesForStudentProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$activitiesForStudentHash,
        dependencies: ActivitiesForStudentFamily._dependencies,
        allTransitiveDependencies:
            ActivitiesForStudentFamily._allTransitiveDependencies,
        studentId: studentId,
      );

  ActivitiesForStudentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
  }) : super.internal();

  final int studentId;

  @override
  Override overrideWith(
    Stream<List<StudentActivity>> Function(ActivitiesForStudentRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActivitiesForStudentProvider._internal(
        (ref) => create(ref as ActivitiesForStudentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<StudentActivity>> createElement() {
    return _ActivitiesForStudentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivitiesForStudentProvider &&
        other.studentId == studentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ActivitiesForStudentRef
    on AutoDisposeStreamProviderRef<List<StudentActivity>> {
  /// The parameter `studentId` of this provider.
  int get studentId;
}

class _ActivitiesForStudentProviderElement
    extends AutoDisposeStreamProviderElement<List<StudentActivity>>
    with ActivitiesForStudentRef {
  _ActivitiesForStudentProviderElement(super.provider);

  @override
  int get studentId => (origin as ActivitiesForStudentProvider).studentId;
}

String _$studentActivityRepositoryHash() =>
    r'dee2ae0441c4d798d36d7939e47b1c6155c5ecc8';

/// See also [StudentActivityRepository].
@ProviderFor(StudentActivityRepository)
final studentActivityRepositoryProvider = AutoDisposeNotifierProvider<
  StudentActivityRepository,
  AppDatabase
>.internal(
  StudentActivityRepository.new,
  name: r'studentActivityRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$studentActivityRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StudentActivityRepository = AutoDisposeNotifier<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
