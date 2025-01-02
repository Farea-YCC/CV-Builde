import 'package:flutter/material.dart';
import 'package:learning/models/experience.dart';
import 'package:learning/providers/experience_provider.dart';
import 'package:learning/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExperienceForm extends StatefulWidget {
   const ExperienceForm({super.key});

  @override
  State<ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _datesController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _datesController.dispose();
    _descriptionController.dispose();
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
        _datesController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding:  const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: _titleController,
                label: l10n.jobTitle,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a job title' : null,
              ),
               const SizedBox(height: 8),
              CustomTextField(
                controller: _companyController,
                label: l10n.company,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a company' : null,
              ),
               const SizedBox(height: 8),
              TextFormField(
                controller: _datesController,
                decoration:  InputDecoration(
                  labelText: l10n.date,
                  border:  const OutlineInputBorder(),
                  suffixIcon:  const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter dates' : null,
              ),
               const SizedBox(height: 8),
              CustomTextField(
                controller: _descriptionController,
                label: l10n.description,
                maxLines: 3,
                validator: (value) => value?.isEmpty ?? true
                    ? 'Please enter a description'
                    : null,
              ),
               const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child:  Text(l10n.cancel),
                  ),
                  ElevatedButton(
                    onPressed: _saveExperience,
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

  void _saveExperience() {
    if (_formKey.currentState?.validate() ?? false) {
      final experience = Experience(
        title: _titleController.text,
        company: _companyController.text,
        dates: _datesController.text,
        description: _descriptionController.text,
      );
      context.read<ExperienceProvider>().addExperience(experience);
      Navigator.pop(context);
    }
  }
}
