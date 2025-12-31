import 'package:flutter/material.dart';
import 'package:hello_world_flutter/screens/counter/states/counter_page_state.dart';
import 'package:hello_world_flutter/screens/home/home_page.dart';
import 'package:hello_world_flutter/screens/home/states/home_page_state.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePageState()),
        ChangeNotifierProvider(create: (context) => CounterPageState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Word Pairs',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: HomePage(),
      ),
    );
  }
}