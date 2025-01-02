import 'package:flutter/material.dart';
import 'package:learning/providers/experience_provider.dart';
import 'package:learning/screens/widgets/experience_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExperienceTab extends StatelessWidget {
  const ExperienceTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<ExperienceProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.experiences.length + 1,
          itemBuilder: (context, index) {
            if (index == provider.experiences.length) {
              return ElevatedButton.icon(
                onPressed: () => _showAddExperienceDialog(context),
                icon: const Icon(Icons.add),
                label: Text(l10n.addExperience),
              );
            }

            final experience = provider.experiences[index];
            return Card(
              child: ListTile(
                title: Text(experience.title),
                subtitle: Text('${experience.company} (${experience.dates})'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => provider.removeExperience(index),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddExperienceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: ExperienceForm(),
      ),
    );
  }
}
