class Education {
  final String degree;
  final String major;
  final String university;
  final String graduationDate;

  Education({
    required this.degree,
    required this.major,
    required this.university,
    required this.graduationDate,
  });

  Map<String, dynamic> toJson() => {
    'degree': degree,
    'major': major,
    'university': university,
    'graduationDate': graduationDate,
  };

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    degree: json['degree'] ?? '',
    major: json['major'] ?? '',
    university: json['university'] ?? '',
    graduationDate: json['graduationDate'] ?? '',
  );
}