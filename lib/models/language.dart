class Language {
  final String name;
  final String level;

  Language({
    required this.name,
    required this.level,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'level': level,
  };

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    name: json['name'] ?? '',
    level: json['level'] ?? '',
  );
}