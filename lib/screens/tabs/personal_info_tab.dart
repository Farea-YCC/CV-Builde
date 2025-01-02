import 'package:flutter/material.dart';
import 'package:learning/providers/personal_info_provider.dart';
import 'package:learning/screens/widgets/personal_info_form.dart';
import 'package:provider/provider.dart';
class PersonalInfoTab extends StatelessWidget {
  const PersonalInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalInfoProvider>(
      builder: (context, provider, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
           const SizedBox(height: 8),
              PersonalInfoForm(
                onSaved: (info) => provider.updatePersonalInfo(info),
                initialInfo: provider.personalInfo,
              ),
            ],
          ),
        );
      },
    );
  }
}