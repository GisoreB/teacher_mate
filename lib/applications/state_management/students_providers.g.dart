// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'students_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$studentsByClassHash() => r'10700a88f9d9c5adcb2d6b7f3a38ecd31f975c12';

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

/// See also [studentsByClass].
@ProviderFor(studentsByClass)
const studentsByClassProvider = StudentsByClassFamily();

/// See also [studentsByClass].
class StudentsByClassFamily extends Family<AsyncValue<List<Student>>> {
  /// See also [studentsByClass].
  const StudentsByClassFamily();

  /// See also [studentsByClass].
  StudentsByClassProvider call(int classId) {
    return StudentsByClassProvider(classId);
  }

  @override
  StudentsByClassProvider getProviderOverride(
    covariant StudentsByClassProvider provider,
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
  String? get name => r'studentsByClassProvider';
}

/// See also [studentsByClass].
class StudentsByClassProvider extends AutoDisposeStreamProvider<List<Student>> {
  /// See also [studentsByClass].
  StudentsByClassProvider(int classId)
    : this._internal(
        (ref) => studentsByClass(ref as StudentsByClassRef, classId),
        from: studentsByClassProvider,
        name: r'studentsByClassProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$studentsByClassHash,
        dependencies: StudentsByClassFamily._dependencies,
        allTransitiveDependencies:
            StudentsByClassFamily._allTransitiveDependencies,
        classId: classId,
      );

  StudentsByClassProvider._internal(
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
    Stream<List<Student>> Function(StudentsByClassRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StudentsByClassProvider._internal(
        (ref) => create(ref as StudentsByClassRef),
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
  AutoDisposeStreamProviderElement<List<Student>> createElement() {
    return _StudentsByClassProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StudentsByClassProvider && other.classId == classId;
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
mixin StudentsByClassRef on AutoDisposeStreamProviderRef<List<Student>> {
  /// The parameter `classId` of this provider.
  int get classId;
}

class _StudentsByClassProviderElement
    extends AutoDisposeStreamProviderElement<List<Student>>
    with StudentsByClassRef {
  _StudentsByClassProviderElement(super.provider);

  @override
  int get classId => (origin as StudentsByClassProvider).classId;
}

String _$singleStudentHash() => r'9a2002992684297b18b793536d005442fdfd8bfe';

/// See also [singleStudent].
@ProviderFor(singleStudent)
const singleStudentProvider = SingleStudentFamily();

/// See also [singleStudent].
class SingleStudentFamily extends Family<AsyncValue<Student>> {
  /// See also [singleStudent].
  const SingleStudentFamily();

  /// See also [singleStudent].
  SingleStudentProvider call(int studentId) {
    return SingleStudentProvider(studentId);
  }

  @override
  SingleStudentProvider getProviderOverride(
    covariant SingleStudentProvider provider,
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
  String? get name => r'singleStudentProvider';
}

/// See also [singleStudent].
class SingleStudentProvider extends AutoDisposeStreamProvider<Student> {
  /// See also [singleStudent].
  SingleStudentProvider(int studentId)
    : this._internal(
        (ref) => singleStudent(ref as SingleStudentRef, studentId),
        from: singleStudentProvider,
        name: r'singleStudentProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$singleStudentHash,
        dependencies: SingleStudentFamily._dependencies,
        allTransitiveDependencies:
            SingleStudentFamily._allTransitiveDependencies,
        studentId: studentId,
      );

  SingleStudentProvider._internal(
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
    Stream<Student> Function(SingleStudentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SingleStudentProvider._internal(
        (ref) => create(ref as SingleStudentRef),
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
  AutoDisposeStreamProviderElement<Student> createElement() {
    return _SingleStudentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleStudentProvider && other.studentId == studentId;
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
mixin SingleStudentRef on AutoDisposeStreamProviderRef<Student> {
  /// The parameter `studentId` of this provider.
  int get studentId;
}

class _SingleStudentProviderElement
    extends AutoDisposeStreamProviderElement<Student>
    with SingleStudentRef {
  _SingleStudentProviderElement(super.provider);

  @override
  int get studentId => (origin as SingleStudentProvider).studentId;
}

String _$studentRepositoryHash() => r'6a288bf502e7589424b2a6046bb975b64f744af0';

/// See also [StudentRepository].
@ProviderFor(StudentRepository)
final studentRepositoryProvider =
    AutoDisposeNotifierProvider<StudentRepository, AppDatabase>.internal(
      StudentRepository.new,
      name: r'studentRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$studentRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$StudentRepository = AutoDisposeNotifier<AppDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
