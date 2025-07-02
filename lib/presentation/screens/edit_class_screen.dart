import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' as drift;
import 'package:teacher_mate/applications/state_management/classes_providers.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';

class EditClassScreen extends ConsumerStatefulWidget {
  final int classId;

  const EditClassScreen({super.key, required this.classId});

  @override
  ConsumerState<EditClassScreen> createState() => _EditClassScreenState();
}

class _EditClassScreenState extends ConsumerState<EditClassScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _durationController = TextEditingController();
  final _syllabusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-populate fields if data is already available
    final classAsync = ref.read(singleClassProvider(widget.classId));
    if (classAsync is AsyncData<Class>) {
      _populateControllers(classAsync.value);
    }
  }

  void _populateControllers(Class classData) {
    _titleController.text = classData.title;
    _descriptionController.text = classData.description ?? '';
    _durationController.text = classData.duration.toString();
    _syllabusController.text = classData.syllabus ?? '';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    _syllabusController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      // Use the update method to save changes to the existing class
      await ref
          .read(classRepositoryProvider.notifier)
          .updateClass(
            widget.classId,
            ClassesCompanion(
              title: drift.Value(_titleController.text),
              description: drift.Value(_descriptionController.text),
              syllabus: drift.Value(_syllabusController.text),
              duration: drift.Value(int.parse(_durationController.text)),
            ),
          );

      if (!mounted) return;
      context.pop();
    }
  }

  Widget _buildIconInputRow(IconData icon, Widget field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Expanded(child: field),
          const SizedBox(width: 32),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final classAsync = ref.watch(singleClassProvider(widget.classId));

    // Listen to the provider to populate controllers when data arrives
    ref.listen<AsyncValue<Class>>(singleClassProvider(widget.classId), (
      previous,
      next,
    ) {
      if (next is AsyncData && !next.isLoading) {
        _populateControllers(next.value!);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editClass),
        actions: [
          FilledButton(
            onPressed: _submitForm,
            child: Text(AppLocalizations.of(context)!.save),
          ),
          const SizedBox(width: 12),
        ],
      ),
      // Use .when to handle loading/error states gracefully
      body: classAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data:
            (classData) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconInputRow(
                        Icons.title,
                        TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.classTitleLabel,
                            border: const OutlineInputBorder(),
                          ),
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? AppLocalizations.of(
                                        context,
                                      )!.enterClassTitleError
                                      : null,
                        ),
                      ),
                      _buildIconInputRow(
                        Icons.description,
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.descriptionLabel,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      _buildIconInputRow(
                        Icons.timer,
                        TextFormField(
                          controller: _durationController,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.durationLabel,
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? AppLocalizations.of(
                                        context,
                                      )!.enterDurationError
                                      : null,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildIconInputRow(
                        Icons.book,
                        TextFormField(
                          controller: _syllabusController,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.syllabusLabel,
                            border: const OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          AppLocalizations.of(context)!.requiredFieldsNote,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
