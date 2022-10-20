import 'package:flutter/material.dart';
import 'package:flutter_apidog/paginas/home.dart';

void main() {
  runApp(const DogApi());
}

class DogApi extends StatelessWidget {
  const DogApi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home(), debugShowCheckedModeBanner: false);
  }
}
