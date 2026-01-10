import 'package:flutter/material.dart';
import 'package:hello_world_flutter/services/backend_services.dart';
import 'package:hello_world_flutter/services/models/person.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  List<Person>? _personList;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Theme.of(context).primaryColorLight,
              minimumSize: Size(double.infinity, 32),
            ),
            onPressed: () async {
              final persons = await BackendServices().fetchPersons();
              setState(() {
                _personList = persons;
              });
            },
            child: Text(
              "Get People",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        if (_personList != null && _personList!.isNotEmpty)
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: _personList!.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      _personList![index].name[0],
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary
                      ),
                    ),
                  ),
                  title: Text(
                    _personList![index].name,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary
                    ),
                  ),
                  subtitle: Text(
                    "${_personList![index].name} ${_personList![index].surname}",
                  ),
                  trailing: Icon(Icons.delete_outlined),
                );
              },
            ),
          ),
      ],
    );
  }
}
