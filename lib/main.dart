import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_example/bloc/stopwatch_bloc.dart';
import 'package:stream_example/example/ex1_clock_screen.dart';
import 'package:stream_example/example/ex2_stop_watch_screen.dart';
import 'package:stream_example/example/ex3_future_builder_example.dart';
import 'package:stream_example/example/ex4_future_builder_http_example.dart';
import 'package:stream_example/example/ex5_bloc_stop_watch_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StopwatchBloc>(
      create: (context) => StopwatchBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SliverExampleNavigatorList(),
      ),
    );
  }
}

final List<Map<String, dynamic>> _example = [
  {
    'title': 'ClockScreen',
    'widget': const ClockScreen(),
  },
  {
    'title': 'StopWatchScreen',
    'widget': const StopWatchScreen(),
  },
  {
    'title': 'FutureBuilderExample',
    'widget': const FutureBuilderExample(),
  },
  {
    'title': 'FutureBuilderHttpExample',
    'widget': const FutureBuilderHttpExample(),
  },
  {
    'title': 'BlocStopWatchScreen',
    'widget': const BlocStopWatchScreen(),
  },
];

class SliverExampleNavigatorList extends StatelessWidget {
  const SliverExampleNavigatorList({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Text(
              'sliver examples',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: ListView.builder(
          itemCount: _example.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(_example[index]['title']),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => _example[index]['widget']),
            ),
          ),
        ),
      );
}
