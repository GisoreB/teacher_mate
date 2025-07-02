// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessions_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionsByClassHash() => r'fc61ced994dc5ea93f69a248971ca828930f3d2e';

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

/// See also [sessionsByClass].
@ProviderFor(sessionsByClass)
const sessionsByClassProvider = SessionsByClassFamily();

/// See also [sessionsByClass].
class SessionsByClassFamily extends Family<AsyncValue<List<Session>>> {
  /// See also [sessionsByClass].
  const SessionsByClassFamily();

  /// See also [sessionsByClass].
  SessionsByClassProvider call(int classId) {
    return SessionsByClassProvider(classId);
  }

  @override
  SessionsByClassProvider getProviderOverride(
    covariant SessionsByClassProvider provider,
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
  String? get name => r'sessionsByClassProvider';
}

/// See also [sessionsByClass].
class SessionsByClassProvider extends AutoDisposeStreamProvider<List<Session>> {
  /// See also [sessionsByClass].
  SessionsByClassProvider(int classId)
    : this._internal(
        (ref) => sessionsByClass(ref as SessionsByClassRef, classId),
        from: sessionsByClassProvider,
        name: r'sessionsByClassProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$sessionsByClassHash,
        dependencies: SessionsByClassFamily._dependencies,
        allTransitiveDependencies:
            SessionsByClassFamily._allTransitiveDependencies,
        classId: classId,
      );

  SessionsByClassProvider._internal(
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
    Stream<List<Session>> Function(SessionsByClassRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SessionsByClassProvider._internal(
        (ref) => create(ref as SessionsByClassRef),
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
  AutoDisposeStreamProviderElement<List<Session>> createElement() {
    return _SessionsByClassProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SessionsByClassProvider && other.classId == classId;
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
mixin SessionsByClassRef on AutoDisposeStreamProviderRef<List<Session>> {
  /// The parameter `classId` of this provider.
  int get classId;
}

class _SessionsByClassProviderElement
    extends AutoDisposeStreamProviderElement<List<Session>>
    with SessionsByClassRef {
  _SessionsByClassProviderElement(super.provider);

  @override
  int get classId => (origin as SessionsByClassProvider).classId;
}

String _$singleSessionHash() => r'd01901181a6b8914a36a62920a64ff697485769f';

/// See also [singleSession].
@ProviderFor(singleSession)
const singleSessionProvider = SingleSessionFamily();

/// See also [singleSession].
class SingleSessionFamily extends Family<AsyncValue<Session>> {
  /// See also [singleSession].
  const SingleSessionFamily();

  /// See also [singleSession].
  SingleSessionProvider call(int sessionId) {
    return SingleSessionProvider(sessionId);
  }

  @override
  SingleSessionProvider getProviderOverride(
    covariant SingleSessionProvider provider,
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
  String? get name => r'singleSessionProvider';
}

/// See also [singleSession].
class SingleSessionProvider extends AutoDisposeStreamProvider<Session> {
  /// See also [singleSession].
  SingleSessionProvider(int sessionId)
    : this._internal(
        (ref) => singleSession(ref as SingleSessionRef, sessionId),
        from: singleSessionProvider,
        name: r'singleSessionProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$singleSessionHash,
        dependencies: SingleSessionFamily._dependencies,
        allTransitiveDependencies:
            SingleSessionFamily._allTransitiveDependencies,
        sessionId: sessionId,
      );

  SingleSessionProvider._internal(
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
    Stream<Session> Function(SingleSessionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SingleSessionProvider._internal(
        (ref) => create(ref as SingleSessionRef),
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
  AutoDisposeStreamProviderElement<Session> createElement() {
    return _SingleSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleSessionProvider && other.sessionId == sessionId;
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
mixin SingleSessionRef on AutoDisposeStreamProviderRef<Session> {
  /// The parameter `sessionId` of this provider.
  int get sessionId;
}

class _SingleSessionProviderElement
    extends AutoDisposeStreamProviderElement<Session>
    with SingleSessionRef {
  _SingleSessionProviderElement(super.provider);

  @override
  int get sessionId => (origin as SingleSessionProvider).sessionId;
}

String _$upcomingSessionsHash() => r'c1e6de7cd62ccda066e67cc51c144e72385e9583';

/// See also [upcomingSessions].
@ProviderFor(upcomingSessions)
final upcomingSessionsProvider =
    AutoDisposeStreamProvider<List<UpcomingSessionData>>.internal(
      upcomingSessions,
      name: r'upcomingSessionsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$upcomingSessionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingSessionsRef =
    AutoDisposeStreamProviderRef<List<UpcomingSessionData>>;
String _$scheduledSessionsCountHash() =>
    r'3c6a63a0993515a9da193589788aea0644841b90';

/// See also [scheduledSessionsCount].
@ProviderFor(scheduledSessionsCount)
const scheduledSessionsCountProvider = ScheduledSessionsCountFamily();

/// See also [scheduledSessionsCount].
class ScheduledSessionsCountFamily extends Family<AsyncValue<int>> {
  /// See also [scheduledSessionsCount].
  const ScheduledSessionsCountFamily();

  /// See also [scheduledSessionsCount].
  ScheduledSessionsCountProvider call(int classId) {
    return ScheduledSessionsCountProvider(classId);
  }

  @override
  ScheduledSessionsCountProvider getProviderOverride(
    covariant ScheduledSessionsCountProvider provider,
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
  String? get name => r'scheduledSessionsCountProvider';
}

/// See also [scheduledSessionsCount].
class ScheduledSessionsCountProvider extends AutoDisposeStreamProvider<int> {
  /// See also [scheduledSessionsCount].
  ScheduledSessionsCountProvider(int classId)
    : this._internal(
        (ref) =>
            scheduledSessionsCount(ref as ScheduledSessionsCountRef, classId),
        from: scheduledSessionsCountProvider,
        name: r'scheduledSessionsCountProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$scheduledSessionsCountHash,
        dependencies: ScheduledSessionsCountFamily._dependencies,
        allTransitiveDependencies:
            ScheduledSessionsCountFamily._allTransitiveDependencies,
        classId: classId,
      );

  ScheduledSessionsCountProvider._internal(
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
    Stream<int> Function(ScheduledSessionsCountRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ScheduledSessionsCountProvider._internal(
        (ref) => create(ref as ScheduledSessionsCountRef),
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
  AutoDisposeStreamProviderElement<int> createElement() {
    return _ScheduledSessionsCountProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ScheduledSessionsCountProvider && other.classId == classId;
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
mixin ScheduledSessionsCountRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `classId` of this provider.
  int get classId;
}

class _ScheduledSessionsCountProviderElement
    extends AutoDisposeStreamProviderElement<int>
    with ScheduledSessionsCountRef {
  _ScheduledSessionsCountProviderElement(super.provider);

  @override
  int get classId => (origin as ScheduledSessionsCountProvider).classId;
}

String _$sessionRepositoryHash() => r'71f1f4cbda9d0f1348e89f54efbc44b9204f3bbf';

/// See also [SessionRepository].
@ProviderFor(SessionRepository)
final sessionRepositoryProvider =
    AutoDisposeNotifierProvider<SessionRepository, AppDatabase>.internal(
      SessionRepository.new,
      name: r'sessionRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$sessionRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SessionRepository = AutoDisposeNotifier<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
