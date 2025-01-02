import 'package:flutter/foundation.dart';
import '../models/education.dart';

class EducationProvider extends ChangeNotifier {
  final List<Education> _education = [];

  List<Education> get education => List.unmodifiable(_education);

  void addEducation(Education education) {
    _education.add(education);
    notifyListeners();
  }

  void removeEducation(int index) {
    _education.removeAt(index);
    notifyListeners();
  }

  void updateEducation(int index, Education education) {
    _education[index] = education;
    notifyListeners();
  }
}