import 'package:flutter/material.dart';
import 'package:hello_world_flutter/screens/counter/states/counter_page_state.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counterState = context.watch<CounterPageState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            color: theme.colorScheme.primary,
            child: Padding(
              padding: const EdgeInsetsGeometry.all(20),
              child: Text('${counterState.counter}', style: style),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              counterState.incrementCounter();
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}