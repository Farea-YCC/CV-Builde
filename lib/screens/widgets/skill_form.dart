import 'package:flutter/material.dart';
import 'package:learning/constants/app_constants.dart';
import 'package:learning/models/skill.dart';
import 'package:learning/providers/skills_provider.dart';
import 'package:learning/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SkillForm extends StatefulWidget {
  const SkillForm({super.key});

  @override
  State<SkillForm> createState() => _SkillFormState();
}

class _SkillFormState extends State<SkillForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedLevel = AppConstants.skillLevels.first;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                label: l10n.skillNameLabel, // Localized string for "Skill Name"
                controller: _nameController,
                validator: (value) =>
                value?.isEmpty ?? true ? l10n.skillNameValidation : null,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedLevel,
                decoration: InputDecoration(
                  labelText: l10n.skillLevelLabel, // Localized string for "Skill Level"
                  border: const OutlineInputBorder(),
                ),
                items: AppConstants.skillLevels.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(l10n.skillLevel(level)), // Localized skill level
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedLevel = value);
                  }
                },
              ),
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
                    onPressed: _saveSkill,
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

  void _saveSkill() {
    if (_formKey.currentState?.validate() ?? false) {
      final skill = Skill(
        name: _nameController.text,
        level: _selectedLevel,
      );
      context.read<SkillsProvider>().addSkill(skill);
      Navigator.pop(context);
    }
  }
}