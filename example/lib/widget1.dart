import 'package:flutter/material.dart';
import 'package:fy_snippet_generator/fy_snippet_generator.dart';

@GenerateSampleCode()
class Widget1 extends StatelessWidget {
  const Widget1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('this is widget 1');
  }
}
