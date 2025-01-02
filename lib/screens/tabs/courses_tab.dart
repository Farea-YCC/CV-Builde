import 'package:flutter/material.dart';
import 'package:learning/providers/courses_provider.dart';
import 'package:learning/screens/widgets/course_form.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CoursesTab extends StatelessWidget {
  const CoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<CoursesProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.courses.length + 1,
          itemBuilder: (context, index) {
            if (index == provider.courses.length) {
              return ElevatedButton.icon(
                onPressed: () => _showAddCourseDialog(context),
                icon: const Icon(Icons.add),
                label:  Text( l10n.addCourse),
              );
            }

            final course = provider.courses[index];
            return Card(
              child: ListTile(
                title: Text(course.title),
                subtitle: Text(course.institution),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => provider.removeCourse(index),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAddCourseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const Dialog(
        child: CourseForm(),
      ),
    );
  }
}