import 'package:flutter/foundation.dart';
import '../models/course.dart';

class CoursesProvider extends ChangeNotifier {
  final List<Course> _courses = [];

  List<Course> get courses => List.unmodifiable(_courses);

  void addCourse(Course course) {
    _courses.add(course);
    notifyListeners();
  }

  void removeCourse(int index) {
    _courses.removeAt(index);
    notifyListeners();
  }

  void updateCourse(int index, Course course) {
    _courses[index] = course;
    notifyListeners();
  }
}