class Experience {
  final String title;
  final String company;
  final String dates;
  final String description;

  Experience({
    required this.title,
    required this.company,
    required this.dates,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'company': company,
    'dates': dates,
    'description': description,
  };

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    title: json['title'] ?? '',
    company: json['company'] ?? '',
    dates: json['dates'] ?? '',
    description: json['description'] ?? '',
  );
}