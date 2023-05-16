import 'package:flutter/material.dart';
// import 'package:rolodex/home_page.dart';
// import 'data/database_helper.dart';

import 'views/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD-QUIZ-8',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const HomePage(title: 'MAD-QUIZ-8'),
    );
  }
}
