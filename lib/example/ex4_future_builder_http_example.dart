import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureBuilderHttpExample extends StatelessWidget {
  const FutureBuilderHttpExample({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('사용자 리스트'),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: fetUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) => ListTile(
                  title: Text(snapshot.data?[index]['name'] ?? '이름값 없음'),
                  subtitle: Text(snapshot.data?[index]['email'] ?? '이메일값 없음'),
                ),
              );
            }
          },
        ),
      );
}

Future<List<dynamic>> fetUsers() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load users');
  }
}
