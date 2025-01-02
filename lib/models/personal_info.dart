class PersonalInfo {
  final String name;
  final String title;
  final String address;
  final String phone;
  final String email;
  final String summary;
  final String imagePath;

  PersonalInfo({
    required this.name,
    required this.title,
    required this.address,
    required this.phone,
    required this.email,
    required this.summary,
    required this.imagePath,
  });

  PersonalInfo copyWith({
    String? name,
    String? title,
    String? address,
    String? phone,
    String? email,
    String? summary,
    String? imagePath,
  }) {
    return PersonalInfo(
      name: name ?? this.name,
      title: title ?? this.title,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      summary: summary ?? this.summary,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'title': title,
    'address': address,
    'phone': phone,
    'email': email,
    'summary': summary,
    'imagePath': imagePath,
  };

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    name: json['name'] ?? '',
    title: json['title'] ?? '',
    address: json['address'] ?? '',
    phone: json['phone'] ?? '',
    email: json['email'] ?? '',
    summary: json['summary'] ?? '',
    imagePath: json['imagePath'] ?? '',
  );
}
