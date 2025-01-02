import 'package:flutter/material.dart';
import 'package:learning/models/education.dart';
import 'package:learning/providers/education_provider.dart';
import 'package:learning/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EducationForm extends StatefulWidget {
  const EducationForm({super.key});

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  final _formKey = GlobalKey<FormState>();
  final _degreeController = TextEditingController();
  final _majorController = TextEditingController();
  final _universityController = TextEditingController();
  final _graduationDateController = TextEditingController();

  @override
  void dispose() {
    _degreeController.dispose();
    _majorController.dispose();
    _universityController.dispose();
    _graduationDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _graduationDateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
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
                label: l10n.degreeLabel,
                controller: _degreeController,
                validator: (value) =>
                value?.isEmpty ?? true ? l10n.degreeValidation : null,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                label: l10n.majorLabel,
                controller: _majorController,
                validator: (value) =>
                value?.isEmpty ?? true ? l10n.majorValidation : null,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                label: l10n.universityLabel,
                controller: _universityController,
                validator: (value) =>
                value?.isEmpty ?? true ? l10n.universityValidation : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _graduationDateController,
                decoration: InputDecoration(
                  labelText: l10n.graduationDateLabel,
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) =>
                value?.isEmpty ?? true ? l10n.graduationDateValidation : null,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveEducation,
                    child: Text(l10n.save),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveEducation() {
    if (_formKey.currentState?.validate() ?? false) {
      final education = Education(
        degree: _degreeController.text,
        major: _majorController.text,
        university: _universityController.text,
        graduationDate: _graduationDateController.text,
      );
      context.read<EducationProvider>().addEducation(education);
      Navigator.pop(context);
    }
  }
}