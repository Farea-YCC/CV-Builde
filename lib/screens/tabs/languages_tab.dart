import 'package:flutter/material.dart';
import 'package:learning/providers/languages_provider.dart';
import 'package:learning/screens/widgets/language_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagesTab extends StatelessWidget {
  const LanguagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<LanguagesProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.languages.length + 1,
          itemBuilder: (context, index) {
            if (index == provider.languages.length) {
              return ElevatedButton.icon(
                onPressed: () => _showAddLanguageDialog(context),
                icon: const Icon(Icons.add),
                label: Text(l10n.addLanguage),
              );
            }

            final language = provider.languages[index];
            return Card(
              child: ListTile(
                title: Text(language.name),
                subtitle: Text(language.level),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => provider.removeLanguage(index),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: LanguageForm(),
      ),
    );
  }
}