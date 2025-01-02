import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning/providers/personal_info_provider.dart';
import 'package:provider/provider.dart';
class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // ignore: use_build_context_synchronously
      context.read<PersonalInfoProvider>().updateProfileImage(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PersonalInfoProvider>(
      builder: (context, provider, child) {
        final imagePath = provider.personalInfo?.imagePath;
        return Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: imagePath != null && File(imagePath).existsSync()
                  ? FileImage(File(imagePath))
                  : const AssetImage('assets/images/logo-ar.webp') as ImageProvider,
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _pickImage(context),
              icon: const Icon(Icons.photo_library),
              label: const Text('Upload Photo'),
            ),
          ],
        );
      },
    );
  }
}
