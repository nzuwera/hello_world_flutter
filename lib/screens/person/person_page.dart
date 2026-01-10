import 'package:flutter/material.dart';
import 'package:hello_world_flutter/screens/person/forms/person_form.dart';
import 'package:hello_world_flutter/services/person_services.dart';
import 'package:hello_world_flutter/services/models/person.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  List<Person>? _personList = [];

 @override
  void initState() {
        super.initState();
        _loadPersons();
  }

  Future<void> _loadPersons() async {
    try {
      final persons = await PersonServices().fetchPersons();
      setState(() {
        _personList = persons;
      });
    } catch (e) {
      // Handle error if needed
      print('Error loading persons: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PersonForm(),
        ),
        SizedBox(height: 15),
        if (_personList != null && _personList!.isNotEmpty)
          _buildPersonsListView(context,_personList!),
      ],
    );
  }

  Widget _buildPersonsListView(BuildContext context, List<Person> personsList) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        itemCount: personsList.length,
        itemBuilder: (_, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    personsList[index].name[0],
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary
                    ),
                  ),
                ),
                title: Text(
                  personsList[index].name,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).colorScheme.primary
                  ),
                ),
                subtitle: Text(
                  "${personsList[index].name} ${personsList[index].surname}",
                ),
                trailing: IconButton(
                  color: Colors.redAccent,
                  icon: Icon(Icons.delete_outlined),
                  onPressed: () async {
                    try {
                      final updatedList = await PersonServices()
                          .deletePerson(personsList[index].surname);
                      setState(() {
                        _personList = updatedList;
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to delete person: $e')),
                      );
                    }
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
