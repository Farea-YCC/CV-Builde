import 'package:flutter/material.dart';
import 'package:learning/providers/courses_provider.dart';
import 'package:learning/providers/education_provider.dart';
import 'package:learning/providers/experience_provider.dart';
import 'package:learning/providers/languages_provider.dart';
import 'package:learning/providers/locale_provider.dart';
import 'package:learning/providers/personal_info_provider.dart';
import 'package:learning/providers/skills_provider.dart';
import 'package:learning/screens/tabs/courses_tab.dart';
import 'package:learning/screens/tabs/education_tab.dart';
import 'package:learning/screens/tabs/experience_tab.dart';
import 'package:learning/screens/tabs/languages_tab.dart';
import 'package:learning/screens/tabs/personal_info_tab.dart';
import 'package:learning/screens/tabs/skills_tab.dart';
import 'package:learning/utils/pdf_generator.dart';
import 'package:learning/widgets/my_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      drawer:const MyDrawer(),
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              context.read<LocaleProvider>().toggleLocale();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: [
            Tab(text: l10n.personalInfo),
            Tab(text: l10n.experience),
            Tab(text: l10n.education),
            Tab(text: l10n.skills),
            Tab(text: l10n.languages),
            Tab(text: l10n.courses),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          PersonalInfoTab(),
          ExperienceTab(),
          EducationTab(),
          SkillsTab(),
          LanguagesTab(),
          CoursesTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _generatePDF(context),
        label: Text(l10n.generatePDF),
        icon: const Icon(Icons.picture_as_pdf),
      ),
    );
  }

  void _generatePDF(BuildContext context) {
    final personalInfo = context.read<PersonalInfoProvider>().personalInfo;
    if (personalInfo == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in your personal information first')),
      );
      return;
    }

    PdfService.generateAndPrint(
      personalInfo: personalInfo,
      experiences: context.read<ExperienceProvider>().experiences,
      education: context.read<EducationProvider>().education,
      skills: context.read<SkillsProvider>().skills,
      languages: context.read<LanguagesProvider>().languages,
      courses: context.read<CoursesProvider>().courses,
      imagePath: personalInfo.imagePath,
    );
  }
}