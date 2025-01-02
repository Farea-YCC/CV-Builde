import 'package:flutter/material.dart';
import 'package:learning/providers/education_provider.dart';
import 'package:learning/screens/widgets/education_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class EducationTab extends StatelessWidget {
  const EducationTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<EducationProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.education.length + 1,
          itemBuilder: (context, index) {
            if (index == provider.education.length) {
              return ElevatedButton.icon(
                onPressed: () => _showAddEducationDialog(context),
                icon: const Icon(Icons.add),
                label: Text(l10n.addEducation),
              );
            }

            final education = provider.education[index];
            return Card(
              child: ListTile(
                title: Text('${education.degree} in ${education.major}'),
                subtitle: Text('${education.university} (${education.graduationDate})'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => provider.removeEducation(index),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddEducationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
      child: EducationForm(),
      ),
    );
  }
}