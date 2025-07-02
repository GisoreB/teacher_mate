import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teacher_mate/applications/state_management/students_providers.dart';
import 'package:teacher_mate/infrastructure/data/app_database.dart';
import 'package:teacher_mate/l10n/app_localizations.dart';
import 'package:teacher_mate/presentation/widgets/icon_input_row_widget.dart';

class AddStudentScreen extends ConsumerStatefulWidget {
  final int classId;

  const AddStudentScreen({super.key, required this.classId});

  @override
  ConsumerState<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends ConsumerState<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();
  final _ageController = TextEditingController();
  final _backgroundController = TextEditingController();

  String selectedMode = 'single';
  final TextEditingController _multipleStudentController =
      TextEditingController();
  final List<String> _students = [];
  final FocusNode _focusNode = FocusNode();

  void _addStudent(String name) {
    if (name.trim().isEmpty) return;
    name = name.trim();
    String name0 = name[0].toUpperCase() + name.substring(1);
    setState(() {
      _students.add(name0.trim());
    });
    _multipleStudentController.clear();
    _focusNode.requestFocus();
  }

  void _removeStudent(String name) {
    setState(() {
      _students.remove(name);
    });
  }

  void _submitForm() async {
    if (selectedMode == 'single') {
      if (_formKey.currentState!.validate()) {
        _nameController.text = _nameController.text.trim();
        _noteController.text = _noteController.text.trim();
        _ageController.text = _ageController.text.trim();
        _backgroundController.text = _backgroundController.text.trim();

        String name =
            _nameController.text[0].toUpperCase() +
            _nameController.text.substring(1);
        ref
            .read(studentRepositoryProvider.notifier)
            .insertStudent(
              StudentsCompanion.insert(
                classId: widget.classId,
                name: name,
                age: drift.Value(int.tryParse(_ageController.text)),
                background: drift.Value(_backgroundController.text),
                note: drift.Value(_noteController.text),
              ),
            );
        if (!mounted) return;
        context.pop();
      }
    } else {
      if (_students.isNotEmpty) {
        for (String student in _students) {
          ref
              .read(studentRepositoryProvider.notifier)
              .insertStudent(
                StudentsCompanion.insert(
                  classId: widget.classId,
                  name: student,
                ),
              );
        }
        if (!mounted) return;
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createStudent),
        actions: [
          FilledButton(
            onPressed: _submitForm,
            child: Text(AppLocalizations.of(context)!.save),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    showCheckmark: false,
                    label: Center(child: Text(AppLocalizations.of(context)!.addModeSingle)),
                    selected: selectedMode == 'single',
                    onSelected: (_) {
                      setState(() {
                        selectedMode = 'single';
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ChoiceChip(
                    showCheckmark: false,
                    label: Center(child: Text(AppLocalizations.of(context)!.addModeMultiple)),
                    selected: selectedMode == 'multiple',
                    onSelected: (_) {
                      setState(() {
                        selectedMode = 'multiple';
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (selectedMode == 'single')
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconInputRow(
                        icon: Icons.person,
                        child: TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.studentNameLabel,
                            border: const OutlineInputBorder(),
                          ),
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? AppLocalizations.of(
                                        context,
                                      )!.enterStudentNameError
                                      : null,
                        ),
                      ),
                      IconInputRow(
                        icon: Icons.timelapse,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: _ageController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.age,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconInputRow(
                        icon: Icons.description,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          controller: _backgroundController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.background,
                            border: const OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                      ),
                      IconInputRow(
                        icon: Icons.note,
                        child: TextFormField(
                          controller: _noteController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.noteLabel,
                            border: const OutlineInputBorder(),
                          ),
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          AppLocalizations.of(context)!.requiredFieldsNote,
                          style: Theme.of(
                            context,
                          ).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconInputRow(
                    icon: Icons.person,
                    child: TextField(
                      onSubmitted: _addStudent,
                      autofocus: true,
                      focusNode: _focusNode,
                      controller: _multipleStudentController,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.studentNameLabel,
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed:
                              () =>
                                  _addStudent(_multipleStudentController.text),
                        ),
                      ),
                    ),
                  ),
                  // Chip list
                  IconInputRow(
                    icon: Icons.groups_2,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 1.45,
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 8,
                          children:
                              _students.map((name) {
                                return InputChip(
                                  label: Text(name),
                                  onDeleted: () => _removeStudent(name),
                                  deleteIcon: Icon(Icons.close),
                                );
                              }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
