class Skill {
  final String name;
  final String level;

  Skill({
    required this.name,
    required this.level,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'level': level,
  };

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
    name: json['name'] ?? '',
    level: json['level'] ?? '',
  );
}