import 'package:flutter/material.dart';

class FutureBuilderExample extends StatelessWidget {
  const FutureBuilderExample({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Future Builder Example'),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Data: ${snapshot.data ?? '데이터 없음'}');
              }
            },
          ),
        ),
      );
}

Future<String> fetchData() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Hello, FutureBuilder!';
}
