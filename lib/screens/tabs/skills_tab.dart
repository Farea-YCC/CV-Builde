import 'package:flutter/material.dart';
import 'package:learning/providers/skills_provider.dart';
import 'package:learning/screens/widgets/skill_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SkillsTab extends StatelessWidget {
  const SkillsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<SkillsProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.skills.length + 1,
          itemBuilder: (context, index) {
            if (index == provider.skills.length) {
              return ElevatedButton.icon(
                onPressed: () => _showAddSkillDialog(context),
                icon: const Icon(Icons.add),
                label:  Text( l10n.addSkill),
              );
            }

            final skill = provider.skills[index];
            return Card(
              child: ListTile(
                title: Text(skill.name),
                subtitle: Text(skill.level),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => provider.removeSkill(index),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddSkillDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
      child: SkillForm(),
      ),
    );
  }
}