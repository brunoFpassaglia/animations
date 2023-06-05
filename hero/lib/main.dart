import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hero/details_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView.builder(
          itemCount: people.length,
          itemBuilder: ((context, index) {
            var person = people[index];
            log(person.hashCode.toString());
            return ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      person: person,
                    ),
                  ),
                );
              },
              leading: Hero(
                tag: person.hashCode,
                child: Container(
                  width: 15,
                  height: 15,
                  color: Colors.red,
                ),
              ),
              title: Text(person.name),
              subtitle: Text(person.age.toString()),
            );
          }),
        ),
      ),
    );
  }
}

class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}

const people = [
  Person(name: 'Bruno', age: 28, emoji: '😃'),
  Person(name: 'Bruno', age: 28, emoji: '😀'),
  Person(name: 'Bruno', age: 28, emoji: '😁'),
];
