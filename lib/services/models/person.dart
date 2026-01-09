class Person {
  final String name;
  final String surname;

  const Person({required this.name, required this.surname});

  factory Person.fronJson(Map<String, dynamic> json) {
    return switch (json) {
      {'name': String name, 'surname': String surname} => Person(
        name: name,
        surname: surname,
      ),
      _ => throw const FormatException("Failed to load Person"),
    };
  }
}
