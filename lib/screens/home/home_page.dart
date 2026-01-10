import 'package:flutter/material.dart';
import 'package:hello_world_flutter/big_card.dart';
import 'package:hello_world_flutter/screens/counter/counter_page.dart';
import 'package:hello_world_flutter/screens/favorites/favorites_page.dart';
import 'package:hello_world_flutter/screens/form/form_page.dart';
import 'package:hello_world_flutter/screens/home/states/home_page_state.dart';
import 'package:hello_world_flutter/screens/person/person_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
      case 1:
        page = FavoritesPage();
      case 2:
        page = CounterPage();
      case 3:
        page = FormPage();
      case 4:
        page = PersonPage();
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello World Flutter",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).primaryColorLight,
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: page,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_outline),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box_outlined),
            label: 'Count',
          ),
          NavigationDestination(
            icon: Icon(Icons.note_alt_outlined),
            label: 'Form',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            label: 'People',
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<HomePageState>();
    var pair = appState.current;
    IconData icon = appState.favorites.contains(pair)
        ? Icons.favorite
        : Icons.favorite_border;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorites();
                },
                icon: Icon(icon),
                label: Text("Like"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text("Next"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}