import 'package:flutter/material.dart';
import 'package:learning/constants/app_constants.dart';
import 'package:learning/models/language.dart';
import 'package:learning/providers/languages_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageForm extends StatefulWidget {
  const LanguageForm({super.key});

  @override
  State<LanguageForm> createState() => _LanguageFormState();
}

class _LanguageFormState extends State<LanguageForm> {
  final _formKey = GlobalKey<FormState>();
  String _selectedLevel = AppConstants.languageLevels.first;
  String _selectedLanguage = AppConstants.languageNames.first;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                decoration: const InputDecoration(
                  labelText: 'Language Name',
                  border: OutlineInputBorder(),
                ),
                items: AppConstants.languageNames.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedLanguage = value);
                  }
                },
              ),
           const SizedBox(height: 8),
           const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedLevel,
                decoration: const InputDecoration(
                  labelText: 'Proficiency Level',
                  border: OutlineInputBorder(),
                ),
                items: AppConstants.languageLevels.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(level),
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
                    child:  Text(l10n.cancel),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveLanguage,
                    child:  Text(l10n.save),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveLanguage() {
    if (_formKey.currentState?.validate() ?? false) {
      final language = Language(
        name: _selectedLanguage,
        level: _selectedLevel,
      );
      context.read<LanguagesProvider>().addLanguage(language);
      Navigator.pop(context);
    }
  }
}
