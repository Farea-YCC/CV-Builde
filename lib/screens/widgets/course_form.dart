import 'package:flutter/material.dart';
import 'package:learning/constants/app_constants.dart';
import 'package:learning/models/course.dart';
import 'package:learning/providers/courses_provider.dart';
import 'package:learning/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseForm extends StatefulWidget {
  const CourseForm({super.key});

  @override
  State<CourseForm> createState() => _CourseFormState();
}

class _CourseFormState extends State<CourseForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _customInstitutionController = TextEditingController();
  String? _selectedInstitution;

  @override
  void dispose() {
    _titleController.dispose();
    _customInstitutionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                label: l10n.courseTitle, // Localized "Course Title"
                controller: _titleController,
                validator: (value) =>
                value?.isEmpty ?? true ? l10n.courseTitleValidation : null,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedInstitution,
                decoration: InputDecoration(
                  labelText: l10n.institutionLabel, // Localized "Institution"
                  border: const OutlineInputBorder(),
                ),
                items: [
                  ...AppConstants.commonInstitutions.map((institution) {
                    return DropdownMenuItem(
                      value: institution,
                      child: Text(institution),

                    );
                  }),
                  DropdownMenuItem(
                    value: 'other',
                    child: Text(l10n.otherInstitution), // Localized "Other"
                  ),
                ],
                onChanged: (value) {
                  setState(() => _selectedInstitution = value);
                },
              ),
              if (_selectedInstitution == 'other') ...[
                const SizedBox(height: 8),
                CustomTextField(
                  label: l10n.institutionName, // Localized "Institution Name"
                  controller: _customInstitutionController,
                  validator: (value) =>
                  value?.isEmpty ?? true ? l10n.institutionNameValidation : null,
                ),
              ],
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel), // Localized "Cancel"
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveCourse,
                    child: Text(l10n.save), // Localized "Save"
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _saveCourse() {
    if (_formKey.currentState?.validate() ?? false) {
      final institution = _selectedInstitution == 'other'
          ? _customInstitutionController.text
          : _selectedInstitution!;

      final course = Course(
        title: _titleController.text,
        institution: institution,
      );
      context.read<CoursesProvider>().addCourse(course);
      Navigator.pop(context);
    }
  }
}
