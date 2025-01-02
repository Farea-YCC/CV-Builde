class Course {
  final String title;
  final String institution;

  Course({
    required this.title,
    required this.institution,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'institution': institution,
  };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    title: json['title'] ?? '',
    institution: json['institution'] ?? '',
  );
}