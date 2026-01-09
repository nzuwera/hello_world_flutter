import 'dart:convert';

import 'package:hello_world_flutter/services/models/person.dart';
import 'package:http/http.dart' as http;

class BackendServices {
  Future<List<Person>> fetchTexts() async {
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/persons"));
    if(response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((json) => Person.fronJson(json as Map<String, dynamic>))
          .toList();
    }else {
      throw Exception("Failed to load Persons");
    }
  }
}
