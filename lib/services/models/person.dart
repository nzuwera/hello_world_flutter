class Person {
  final String name;
  final String surname;

  const Person({required this.name, required this.surname});

  Person.fromJson(Map<String, dynamic> json)
  : name = json['name'], surname = json['surname'];

  static Map<String, dynamic> toJson (Person value) =>
      {"name": value.name, "surname": value.surname};

}
