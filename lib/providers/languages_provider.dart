import 'package:flutter/foundation.dart';
import '../models/language.dart';
class LanguagesProvider extends ChangeNotifier {
  final List<Language> _languages = [];

  List<Language> get languages => List.unmodifiable(_languages);

  void addLanguage(Language language) {
    _languages.add(language);
    notifyListeners();
  }

  void removeLanguage(int index) {
    _languages.removeAt(index);
    notifyListeners();
  }

  void updateLanguage(int index, Language language) {
    _languages[index] = language;
    notifyListeners();
  }
}