class Patient {

  int? id;
  String name;
  int age;
  String gender;
  String phone;
  String address;
  String notes;

  Patient({
    this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.phone,
    required this.address,
    required this.notes,
  });

  Map<String, dynamic> toMap() {

    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'phone': phone,
      'address': address,
      'notes': notes,
      'synced': 0
    };
  }
}