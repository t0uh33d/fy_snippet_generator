/*
----------------------------------------------------------------------------------
|  This file is generated automatically by FSG. Modify at your own risk!!!  |
----------------------------------------------------------------------------------
*/

import 'package:fy_snippet_generator/fy_snippet_generator.dart';
import 'package:example/widget1.dart';
import 'package:example/home.dart';

class FSGCode {
  static String? getCodeByType<T>() {
    String type = T.toString();
    if (type == "Widget1") {
      return '''
import 'package:flutter/material.dart';
import 'package:fy_snippet_generator/fy_snippet_generator.dart';


class Widget1 extends StatelessWidget {
  const Widget1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('this is widget 1');
  }
}

''';
    }
    if (type == "Home") {
      return '''
import 'package:flutter/material.dart';
import 'package:fy_snippet_generator/fy_snippet_generator.dart';


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

''';
    }
    return null;
  }
}
