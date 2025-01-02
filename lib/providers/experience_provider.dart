import 'package:flutter/foundation.dart';
import '../models/experience.dart';

class ExperienceProvider extends ChangeNotifier {
  final List<Experience> _experiences = [];

  List<Experience> get experiences => List.unmodifiable(_experiences);

  void addExperience(Experience experience) {
    _experiences.add(experience);
    notifyListeners();
  }

  void removeExperience(int index) {
    _experiences.removeAt(index);
    notifyListeners();
  }

  void updateExperience(int index, Experience experience) {
    _experiences[index] = experience;
    notifyListeners();
  }
}