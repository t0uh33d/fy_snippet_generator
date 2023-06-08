import 'package:flutter/material.dart';
import 'package:fy_snippet_generator/fy_snippet_generator.dart';

@GenerateSampleCode()
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Text('this is home');
  }
}
