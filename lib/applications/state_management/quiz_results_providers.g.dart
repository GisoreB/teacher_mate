// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_results_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resultsByQuizHash() => r'f53b78b7bd69b612aeb2b844e9a2691262224a51';

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

/// See also [resultsByQuiz].
@ProviderFor(resultsByQuiz)
const resultsByQuizProvider = ResultsByQuizFamily();

/// See also [resultsByQuiz].
class ResultsByQuizFamily extends Family<AsyncValue<List<QuizResult>>> {
  /// See also [resultsByQuiz].
  const ResultsByQuizFamily();

  /// See also [resultsByQuiz].
  ResultsByQuizProvider call(int quizId) {
    return ResultsByQuizProvider(quizId);
  }

  @override
  ResultsByQuizProvider getProviderOverride(
    covariant ResultsByQuizProvider provider,
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
  String? get name => r'resultsByQuizProvider';
}

/// See also [resultsByQuiz].
class ResultsByQuizProvider
    extends AutoDisposeStreamProvider<List<QuizResult>> {
  /// See also [resultsByQuiz].
  ResultsByQuizProvider(int quizId)
    : this._internal(
        (ref) => resultsByQuiz(ref as ResultsByQuizRef, quizId),
        from: resultsByQuizProvider,
        name: r'resultsByQuizProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$resultsByQuizHash,
        dependencies: ResultsByQuizFamily._dependencies,
        allTransitiveDependencies:
            ResultsByQuizFamily._allTransitiveDependencies,
        quizId: quizId,
      );

  ResultsByQuizProvider._internal(
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
  Override overrideWith(
    Stream<List<QuizResult>> Function(ResultsByQuizRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ResultsByQuizProvider._internal(
        (ref) => create(ref as ResultsByQuizRef),
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
  AutoDisposeStreamProviderElement<List<QuizResult>> createElement() {
    return _ResultsByQuizProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ResultsByQuizProvider && other.quizId == quizId;
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
mixin ResultsByQuizRef on AutoDisposeStreamProviderRef<List<QuizResult>> {
  /// The parameter `quizId` of this provider.
  int get quizId;
}

class _ResultsByQuizProviderElement
    extends AutoDisposeStreamProviderElement<List<QuizResult>>
    with ResultsByQuizRef {
  _ResultsByQuizProviderElement(super.provider);

  @override
  int get quizId => (origin as ResultsByQuizProvider).quizId;
}

String _$quizResultsForStudentHash() =>
    r'2bd34c9df95c425c3851c6cb6c9031c9408b81a0';

/// See also [quizResultsForStudent].
@ProviderFor(quizResultsForStudent)
const quizResultsForStudentProvider = QuizResultsForStudentFamily();

/// See also [quizResultsForStudent].
class QuizResultsForStudentFamily extends Family<AsyncValue<List<QuizResult>>> {
  /// See also [quizResultsForStudent].
  const QuizResultsForStudentFamily();

  /// See also [quizResultsForStudent].
  QuizResultsForStudentProvider call(int studentId) {
    return QuizResultsForStudentProvider(studentId);
  }

  @override
  QuizResultsForStudentProvider getProviderOverride(
    covariant QuizResultsForStudentProvider provider,
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
  String? get name => r'quizResultsForStudentProvider';
}

/// See also [quizResultsForStudent].
class QuizResultsForStudentProvider
    extends AutoDisposeStreamProvider<List<QuizResult>> {
  /// See also [quizResultsForStudent].
  QuizResultsForStudentProvider(int studentId)
    : this._internal(
        (ref) =>
            quizResultsForStudent(ref as QuizResultsForStudentRef, studentId),
        from: quizResultsForStudentProvider,
        name: r'quizResultsForStudentProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$quizResultsForStudentHash,
        dependencies: QuizResultsForStudentFamily._dependencies,
        allTransitiveDependencies:
            QuizResultsForStudentFamily._allTransitiveDependencies,
        studentId: studentId,
      );

  QuizResultsForStudentProvider._internal(
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
    Stream<List<QuizResult>> Function(QuizResultsForStudentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QuizResultsForStudentProvider._internal(
        (ref) => create(ref as QuizResultsForStudentRef),
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
  AutoDisposeStreamProviderElement<List<QuizResult>> createElement() {
    return _QuizResultsForStudentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QuizResultsForStudentProvider &&
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
mixin QuizResultsForStudentRef
    on AutoDisposeStreamProviderRef<List<QuizResult>> {
  /// The parameter `studentId` of this provider.
  int get studentId;
}

class _QuizResultsForStudentProviderElement
    extends AutoDisposeStreamProviderElement<List<QuizResult>>
    with QuizResultsForStudentRef {
  _QuizResultsForStudentProviderElement(super.provider);

  @override
  int get studentId => (origin as QuizResultsForStudentProvider).studentId;
}

String _$quizResultRepositoryHash() =>
    r'cf50f246bad9d33a5e9dd963e42ffe9d5f33fbcf';

/// See also [QuizResultRepository].
@ProviderFor(QuizResultRepository)
final quizResultRepositoryProvider =
    AutoDisposeNotifierProvider<QuizResultRepository, AppDatabase>.internal(
      QuizResultRepository.new,
      name: r'quizResultRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$quizResultRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$QuizResultRepository = AutoDisposeNotifier<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
