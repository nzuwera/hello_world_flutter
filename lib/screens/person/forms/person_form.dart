import 'package:flutter/material.dart';
import 'package:hello_world_flutter/services/models/person.dart';
import 'package:hello_world_flutter/services/person_services.dart';

class PersonForm extends StatefulWidget {
  @override
  _PersonForm createState() => _PersonForm();
}

class _PersonForm extends State<PersonForm> {
  // A key for managing the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Variable to store the entered name
  String _name = '';

  // Variable to store the entered email
  String _surname = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Name",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            onSaved: (value) {
              _name = value!;
            },
          ),
          SizedBox(height: 20.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: "Surname",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your surname';
              }
              return null;
            },
            onSaved: (value) {
              _surname = value!;
            },
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).primaryColorLight,
            ),
            onPressed: _submitForm,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        var person = Person(name: _name, surname: _surname);
        await PersonServices().createPerson(person);

        if (!mounted) return;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Person Added!'),
              content: Text("Name: $_name\nSurname: $_surname"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok', style: TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ],
            );
          },
        );
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add person: $e')),
        );
      }
    }
  }
}
