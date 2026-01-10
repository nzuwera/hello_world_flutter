import 'dart:convert';

import 'package:hello_world_flutter/services/models/person.dart';
import 'package:http/http.dart' as http;

class PersonServices {
  final Uri _url = Uri.parse("http://10.0.2.2:8080/persons");

  Future<List<Person>> fetchPersons() async {
    final response = await http.get(_url);
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((json) => Person.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Failed to load Persons");
    }
  }

  Future<List<Person>> deletePerson(String surname) async {
    final response = await http.delete(
      Uri.parse('$_url/$surname'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((json) => Person.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Failed to load Persons");
    }
  }

  Future<List<Person>> createPerson(Person person) async {
    final response = await http.post(
      _url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(Person.toJson(person)),
    );
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((json) => Person.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Failed to Post Persons");
    }
  }
}
