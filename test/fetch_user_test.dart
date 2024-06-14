import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Fetch users from API and print the result', () async {
    final users = await fetUsers();
    print(users);
    expect(users, isNotEmpty); // 추가적으로 결과가 비어있지 않은지 확인하는 검증 추가
  });
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
