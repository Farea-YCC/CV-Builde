import 'package:flutter/material.dart';
import 'package:learning/models/personal_info.dart';

class PersonalInfoProvider extends ChangeNotifier {
  PersonalInfo? _personalInfo;

  PersonalInfo? get personalInfo => _personalInfo;

  void updatePersonalInfo(PersonalInfo info) {
    _personalInfo = info;
    notifyListeners();
  }

  void updateProfileImage(String imagePath) {
    if (_personalInfo == null) {
      _personalInfo = PersonalInfo(
        name: '',
        title: '',
        address: '',
        phone: '',
        email: '',
        summary: '',
        imagePath: imagePath,
      );
    } else {
      _personalInfo = _personalInfo!.copyWith(imagePath: imagePath);
    }
    notifyListeners();
  }
}
