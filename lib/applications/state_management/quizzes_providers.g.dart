// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quizzes_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quizzesByClassHash() => r'ec076790ef02b0e8280b486233035aef82244394';

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

/// See also [quizzesByClass].
@ProviderFor(quizzesByClass)
const quizzesByClassProvider = QuizzesByClassFamily();

/// See also [quizzesByClass].
class QuizzesByClassFamily extends Family<AsyncValue<List<Quiz>>> {
  /// See also [quizzesByClass].
  const QuizzesByClassFamily();

  /// See also [quizzesByClass].
  QuizzesByClassProvider call(int classId) {
    return QuizzesByClassProvider(classId);
  }

  @override
  QuizzesByClassProvider getProviderOverride(
    covariant QuizzesByClassProvider provider,
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
  String? get name => r'quizzesByClassProvider';
}

/// See also [quizzesByClass].
class QuizzesByClassProvider extends AutoDisposeStreamProvider<List<Quiz>> {
  /// See also [quizzesByClass].
  QuizzesByClassProvider(int classId)
    : this._internal(
        (ref) => quizzesByClass(ref as QuizzesByClassRef, classId),
        from: quizzesByClassProvider,
        name: r'quizzesByClassProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$quizzesByClassHash,
        dependencies: QuizzesByClassFamily._dependencies,
        allTransitiveDependencies:
            QuizzesByClassFamily._allTransitiveDependencies,
        classId: classId,
      );

  QuizzesByClassProvider._internal(
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
    Stream<List<Quiz>> Function(QuizzesByClassRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QuizzesByClassProvider._internal(
        (ref) => create(ref as QuizzesByClassRef),
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
  AutoDisposeStreamProviderElement<List<Quiz>> createElement() {
    return _QuizzesByClassProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizzesByClassProvider && other.classId == classId;
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
mixin QuizzesByClassRef on AutoDisposeStreamProviderRef<List<Quiz>> {
  /// The parameter `classId` of this provider.
  int get classId;
}

class _QuizzesByClassProviderElement
    extends AutoDisposeStreamProviderElement<List<Quiz>>
    with QuizzesByClassRef {
  _QuizzesByClassProviderElement(super.provider);

  @override
  int get classId => (origin as QuizzesByClassProvider).classId;
}

String _$allQuizzesHash() => r'f087093802bb8475629d40c589133cea686d83c3';

/// See also [allQuizzes].
@ProviderFor(allQuizzes)
final allQuizzesProvider = AutoDisposeStreamProvider<List<Quiz>>.internal(
  allQuizzes,
  name: r'allQuizzesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allQuizzesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllQuizzesRef = AutoDisposeStreamProviderRef<List<Quiz>>;
String _$singleQuizHash() => r'023e110b568c0ea72ea87c6f30772f7ed34110f6';

/// See also [singleQuiz].
@ProviderFor(singleQuiz)
const singleQuizProvider = SingleQuizFamily();

/// See also [singleQuiz].
class SingleQuizFamily extends Family<AsyncValue<Quiz>> {
  /// See also [singleQuiz].
  const SingleQuizFamily();

  /// See also [singleQuiz].
  SingleQuizProvider call(int quizId) {
    return SingleQuizProvider(quizId);
  }

  @override
  SingleQuizProvider getProviderOverride(
    covariant SingleQuizProvider provider,
  ) {
    return call(provider.quizId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'singleQuizProvider';
}

/// See also [singleQuiz].
class SingleQuizProvider extends AutoDisposeStreamProvider<Quiz> {
  /// See also [singleQuiz].
  SingleQuizProvider(int quizId)
    : this._internal(
        (ref) => singleQuiz(ref as SingleQuizRef, quizId),
        from: singleQuizProvider,
        name: r'singleQuizProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$singleQuizHash,
        dependencies: SingleQuizFamily._dependencies,
        allTransitiveDependencies: SingleQuizFamily._allTransitiveDependencies,
        quizId: quizId,
      );

  SingleQuizProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.quizId,
  }) : super.internal();

  final int quizId;

  @override
  Override overrideWith(Stream<Quiz> Function(SingleQuizRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: SingleQuizProvider._internal(
        (ref) => create(ref as SingleQuizRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        quizId: quizId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Quiz> createElement() {
    return _SingleQuizProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleQuizProvider && other.quizId == quizId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, quizId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SingleQuizRef on AutoDisposeStreamProviderRef<Quiz> {
  /// The parameter `quizId` of this provider.
  int get quizId;
}

class _SingleQuizProviderElement extends AutoDisposeStreamProviderElement<Quiz>
    with SingleQuizRef {
  _SingleQuizProviderElement(super.provider);

  @override
  int get quizId => (origin as SingleQuizProvider).quizId;
}

String _$upcomingQuizzesHash() => r'9714bcd103b2aa67799f57adebb39f4074a7295a';

/// See also [upcomingQuizzes].
@ProviderFor(upcomingQuizzes)
final upcomingQuizzesProvider =
    AutoDisposeStreamProvider<List<UpcomingQuizData>>.internal(
      upcomingQuizzes,
      name: r'upcomingQuizzesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$upcomingQuizzesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingQuizzesRef =
    AutoDisposeStreamProviderRef<List<UpcomingQuizData>>;
String _$quizRepositoryHash() => r'3feb24ead23f827702e112fd52a31a23df5e7822';

/// See also [QuizRepository].
@ProviderFor(QuizRepository)
final quizRepositoryProvider =
    AutoDisposeNotifierProvider<QuizRepository, AppDatabase>.internal(
      QuizRepository.new,
      name: r'quizRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$quizRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$QuizRepository = AutoDisposeNotifier<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
