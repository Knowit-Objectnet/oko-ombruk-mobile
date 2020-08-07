class Partner {
  final int id;
  final String name;
  final String description;
  final String phone;
  final String email;

  Partner(
    this.id,
    this.name,
    this.description,
    this.phone,
    this.email,
  );

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      json['id'],
      json['name'],
      json['description'],
      json['phone'],
      json['email'],
    );
  }

  Map<String, dynamic> _toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'phone': phone,
        'email': email,
      };

  @override
  String toString() {
    return _toJson().toString();
  }
}
